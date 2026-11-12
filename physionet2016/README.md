# PhysioNet/CinC Challenge 2016: Heart Sound Dataset

Public dataset used to train and evaluate the model:
**"Classification of Normal/Abnormal Heart Sound Recordings: the PhysioNet/Computing in Cardiology Challenge 2016"**
(<https://physionet.org/content/challenge-2016/>).

![PCG with synchronous ECG: S1, systole, S2, diastole](figure1.png)

*PCG signal with synchronous ECG, showing S1, systole, S2 and diastole (figure from the PhysioNet challenge page).*

## Contents

```
physionet2016/
├── training-a/ … training-f/   # 3,153 recordings from 6 independent databases
│   ├── xxxx.wav                # PCG audio, mono, 2,000 Hz, 16-bit
│   ├── xxxx.hea / xxxx.dat     # WFDB header/signal (some sets also include synchronous ECG)
│   ├── REFERENCE.csv           # <record>,<label>   label: -1 = normal, 1 = abnormal
│   ├── REFERENCE-SQI.csv       # label + signal-quality index (1 = good, 0 = unsure/noisy)
│   ├── RECORDS, RECORDS-normal, RECORDS-abnormal
├── validation/                 # 301 records (official validation set). Used as the TEST set in this project.
├── papers/                     # Challenge overview paper + top-ranked entries (Potes, Zabihi, Rubin, …)
├── sources/                    # Source code submitted by challenge participants
├── training.zip, validation.zip, sample2016*.zip   # Original archives
├── figure1.png                 # PCG + ECG example with heart-sound states
├── mathworks.png
```

## Statistics

| Set | Patients | Recordings | Abnormal % | Normal % | Unsure % |
|---|---|---|---|---|---|
| training-a | 121 | 409 | 67.5 | 28.4 | 4.2 |
| training-b | 106 | 490 | 14.9 | 60.2 | 24.9 |
| training-c | 31 | 31 | 64.5 | 22.6 | 12.9 |
| training-d | 38 | 55 | 47.3 | 47.3 | 5.5 |
| training-e | 356 | 2,054 | 7.1 | 86.7 | 6.2 |
| training-f | 112 | 114 | 27.2 | 68.4 | 4.4 |
| **Total** | **764** | **3,153** | **18.2** | **73.0** | **8.8** |

- Recordings come from 7 research groups in 7 countries and were made in both clinical and non-clinical (home) settings.
- Recording length: from a few seconds to about 2 minutes.
- Positions: aortic, pulmonic, tricuspid and mitral areas.
- Devices: Welch Allyn Meditron, 3M Littmann, AUDIOSCOPE and others.

## How it is used in this project

See [`../Model/README.md`](../Model/README.md#1-data-and-split):

- `training-a … f`: patient-level stratified 80 / 20 split into train and internal validation. Abnormal training records are augmented ×3 to reach a 1 : 1 balance.
- `validation/`: 301 records (151 abnormal / 150 normal) used as the held-out **test set**.

> ⚠️ The 301 records in `validation/` are **copies of records that also exist in `training-a … f`** (same IDs). Remove them from the training list before splitting if you need a strictly independent test set.

## Notes

- This folder is listed in `.gitignore` (`physionet2016/`). Files already in the repository are tracked, but new files (including this README) must be added with `git add -f`.
- Citation:
  > Clifford G. D. et al., "Classification of normal/abnormal heart sound recordings: The PhysioNet/Computing in Cardiology Challenge 2016," *Computing in Cardiology*, vol. 43, pp. 609–612, 2016.
  > Goldberger A. et al., "PhysioBank, PhysioToolkit, and PhysioNet," *Circulation*, 101(23), 2000.
- License: Open Data Commons Attribution License v1.0 (see the PhysioNet page).
