% generate_audio.m - Creates a synthetic noisy audio file

Fs = 44100; % Sampling frequency
t = 0:1/Fs:2; % 2 seconds of audio
clean = 0.5 * sin(2 * pi * 440 * t); % Pure tone at 440 Hz (A note)

noise = 0.2 * randn(size(clean)); % Add white noise
noisy = clean + noise; % Noisy audio

audiowrite('noisy_audio.wav', noisy, Fs); % Save it
disp("✅ 'noisy_audio.wav' has been created successfully.");
