% Noise Removal from Audio Signal using Low-Pass Filter

% Step 1: Load the noisy audio
[noisy, Fs] = audioread('noisy_audio.wav');
sound(noisy, Fs);
disp("🔊 Original noisy audio playing...");

% Step 2: Plot original signal
t = (0:length(noisy)-1)/Fs;
figure;
plot(t, noisy);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Noisy Audio');

% Step 3: Design a Low-Pass Filter (Butterworth)
Fc = 1000; % Cutoff frequency in Hz
[b, a] = butter(6, Fc/(Fs/2), 'low');

% Step 4: Apply the filter
cleaned = filter(b, a, noisy);
sound(cleaned, Fs);
disp("🔊 Filtered audio playing...");

% Step 5: Plot cleaned signal
figure;
plot(t, cleaned);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Audio');

% Step 6: Save cleaned audio
audiowrite('cleaned_audio.wav', cleaned, Fs);
disp("✅ Filtered audio saved as cleaned_audio.wav");

% Step 7: Plot spectrograms
figure;
subplot(2,1,1);
spectrogram(noisy, 256, 200, 256, Fs, 'yaxis');
title('Spectrogram - Noisy Audio');

subplot(2,1,2);
spectrogram(cleaned, 256, 200, 256, Fs, 'yaxis');
title('Spectrogram - Filtered Audio');

% Step 8: SNR Calculation
% Recreate the original clean signal (same as in generate_audio.m)
t_clean = (0:1/Fs:2);
clean = 0.5 * sin(2 * pi * 440 * t_clean);

% Match lengths to avoid size errors
min_len = min([length(clean), length(noisy), length(cleaned)]);
clean = clean(1:min_len);
noisy = noisy(1:min_len);
cleaned = cleaned(1:min_len);

% Calculate SNR before filtering
signal_power = mean(clean.^2);
noise_power = mean((noisy - clean).^2);
snr_before = 10 * log10(signal_power / noise_power);

% Calculate SNR after filtering
cleaned_noise = cleaned - clean;
cleaned_noise_power = mean(cleaned_noise.^2);
snr_after = 10 * log10(signal_power / cleaned_noise_power);

fprintf('\n📊 SNR before filtering: %.2f dB\n', snr_before);
fprintf('📊 SNR after filtering: %.2f dB\n', snr_after);
