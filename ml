import numpy as np import pandas as pd
from scipy.fftpack import fft

# Load data from CSV file
file_path = "/content/final_cleaned_sensor_data.csv" df = pd.read_csv(file_path)

# Extract sensor signals
receiver1 = df["Receiver1"].values # Before crack receiver2 = df["Receiver2"].values # After crack

# FFT Parameters
N = 100 # Number of samples per segment
sampling_rate = 1000 # Adjust based on Arduino sampling frequency frequencies = np.fft.fftfreq(N, d=1/sampling_rate)[:N//2] # Positive Frequencies Only

# Function to extract FFT & Amplitude Features def extract_fft_features(signal, freqs):
fft_values = np.abs(fft(signal)[:N//2]) # Compute FFT magnitude

# FFT-Based Features
peak_freq = freqs[np.argmax(fft_values)]
spectral_centroid = np.sum(freqs * fft_values) / np.sum(fft_values) spectral_bandwidth = np.sqrt(np.sum(((freqs - spectral_centroid) ** 2) *
fft_values) / np.sum(fft_values))
rms_power = np.sqrt(np.mean(fft_values ** 2))
 
mean_magnitude = np.mean(fft_values) std_magnitude = np.std(fft_values)

# Amplitude-Based Features max_amplitude = np.max(signal) min_amplitude = np.min(signal) mean_amplitude = np.mean(signal)

return [
peak_freq, spectral_centroid, spectral_bandwidth, rms_power, mean_magnitude, std_magnitude,
max_amplitude, min_amplitude, mean_amplitude
]

# Process Data in Sliding Windows
step_size = N // 2 # Overlapping window (50% overlap) features_list = []

for i in range(0, len(receiver1) - N, step_size): # Extract segment
segment_r1 = receiver1[i:i+N] segment_r2 = receiver2[i:i+N]

# Compute features
features_r1 = extract_fft_features(segment_r1, frequencies) features_r2 = extract_fft_features(segment_r2, frequencies)

# Append to list
features_list.append(["Before Crack"] + features_r1) features_list.append(["After Crack"] + features_r2)

# Convert to DataFrame columns = [
"Condition", "Peak_Frequency", "Spectral_Centroid", "Spectral_Bandwidth", "RMS_Power", "Mean_Magnitude", "STD_Magnitude",
"Max_Amplitude", "Min_Amplitude", "Mean_Amplitude"
]
 
features_df = pd.DataFrame(features_list, columns=columns)

# Save to CSV
features_file = "full_fft_features.csv" features_df.to_csv(features_file, index=False)

# Display extracted features print(features_df.head())
