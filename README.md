# Ai-Based-Acoustic-Wave-Monitoring-To-Detect-Rail-Cracks
This project presents a real-time rail crack detection system using acoustic wave monitoring and machine learning. Piezoelectric sensors are used to transmit and receive signals along a rail track, and changes in those signals — caused by structural defects — are analyzed using Fast Fourier Transform (FFT) and classified using a Support Vector Machine (SVM) model. The system operates using an ESP32 microcontroller and is designed for accurate, low-cost, and non-invasive railway track monitoring.



 Project Objective

To design and implement an automated rail crack detection system that:
- Monitors structural integrity using acoustic wave propagation.
- Extracts key signal features using FFT-based analysis.
- Classifies cracked vs. non-cracked track sections using an SVM model.
- Provides accurate, real-time detection without the need for GSM/GPS or cloud connectivity.



Technologies Used

 Hardware
- ESP32 microcontroller
- Piezoelectric transducers (PZT-5A)
- LM358 operational amplifier
- Breadboard, jumper wires, power supply

 Software & Tools
- Arduino IDE (C programming for ESP32)
- Python (for model training and data processing)
- Google Colab / Jupyter Notebook

Python Libraries Used
- `numpy` – Numerical operations and FFT
- `pandas` – Reading sensor data from CSV
- `scipy` – Signal processing and FFT feature extraction
- `scikit-learn` – SVM model training and evaluation
- `matplotlib` – Data visualization

---

System Overview

1. Acoustic Signal Transmission
   A 1 kHz square wave is transmitted using a piezoelectric element.

2. Sensor Data Collection
   Two piezoelectric receivers capture acoustic signals at different positions (before and after a crack).

3. Feature Extraction
   - FFT is applied to sensor readings.
   - Key frequency-domain features: peak frequency, spectral centroid, bandwidth, RMS power, spectral flatness.

4. Model Training (Offline)
   - Labeled data is used to train an SVM classifier in Python.
   - The trained model is tested for accuracy, recall, and F1 score.

5. Real-Time Classification (On ESP32) 
   - The ESP32 samples sensor data.
   - Extracted features are compared against thresholds to detect cracks.

---

How to Set Up

 Hardware Connections
- Connect piezo transmitter to ESP32's PWM output.
- Connect two piezo receivers to analog input pins via LM358 amplification.
- Power the ESP32 through USB or external power source.

Software Steps
1. Upload `main.ino` to ESP32 via Arduino IDE.
2. Collect raw data and save as `.csv` using the Serial Monitor.
3. Use `fft_feature_extraction.py` in Python to extract features.
4. Train and test the SVM model using `scikit-learn`.
5. Implement basic classification logic or thresholds in ESP32 code (if not deploying full ML model).

---

Results

- Crack detection accuracy: 97.5%
- Minimum crack size detected: 2 mm
- SVM ROC AUC score: 1.00
- Inference time on ESP32 (threshold-based): < 15 ms

---

## 📈 Sample Signal Behavior

| Signal Point     | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| **Before Crack** | Stable waveform, consistent amplitude and frequency                         |
| **At Crack**     | Amplitude distortion, energy loss, and altered wave shape                   |
| **After Crack**  | Slight frequency shift, altered resonance due to structural discontinuity   |

---


