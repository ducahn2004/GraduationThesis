"""Extract figures for the README files.

Usage:
  python docs/extract_figures.py pdf   <file.pdf>   --out docs/_extracted [--render] [--dpi 200] [--pages 9 10]
  python docs/extract_figures.py ipynb <file.ipynb> --out docs/_extracted

pdf   : saves every embedded raster image (page<N>_img<K>.<ext>). With --render,
        also renders whole pages to PNG (useful for vector diagrams).
        Requires: pip install pymupdf
ipynb : saves every PNG plot stored in the notebook outputs (cell<N>_out<K>.png).
        Works with the extension-less ConvertToTFLite notebooks too.
"""
import argparse
import base64
import json
from pathlib import Path


def extract_pdf(path: Path, out: Path, render: bool, dpi: int, pages):
    import fitz  # PyMuPDF

    doc = fitz.open(path)
    wanted = set(pages) if pages else set(range(1, doc.page_count + 1))
    n = 0
    for pno in sorted(wanted):
        page = doc[pno - 1]
        for k, img in enumerate(page.get_images(full=True), 1):
            info = doc.extract_image(img[0])
            if info["width"] < 80 or info["height"] < 80:  # skip logos/icons
                continue
            (out / f"page{pno:03d}_img{k}.{info['ext']}").write_bytes(info["image"])
            n += 1
        if render:
            page.get_pixmap(dpi=dpi).save(out / f"page{pno:03d}_full.png")
            n += 1
    print(f"{n} file(s) written to {out}")


def extract_ipynb(path: Path, out: Path):
    nb = json.loads(path.read_text(encoding="utf-8"))
    n = 0
    for ci, cell in enumerate(nb.get("cells", [])):
        for oi, o in enumerate(cell.get("outputs", [])):
            png = o.get("data", {}).get("image/png")
            if png:
                data = "".join(png) if isinstance(png, list) else png
                (out / f"cell{ci:03d}_out{oi}.png").write_bytes(base64.b64decode(data))
                n += 1
    print(f"{n} plot(s) written to {out}")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("mode", choices=["pdf", "ipynb"])
    ap.add_argument("src", type=Path)
    ap.add_argument("--out", type=Path, default=Path("docs/_extracted"))
    ap.add_argument("--render", action="store_true", help="pdf: also render full pages")
    ap.add_argument("--dpi", type=int, default=200)
    ap.add_argument("--pages", type=int, nargs="*", help="pdf: 1-based page numbers")
    a = ap.parse_args()

    out = a.out / a.src.stem
    out.mkdir(parents=True, exist_ok=True)
    if a.mode == "pdf":
        extract_pdf(a.src, out, a.render, a.dpi, a.pages)
    else:
        extract_ipynb(a.src, out)


if __name__ == "__main__":
    main()
