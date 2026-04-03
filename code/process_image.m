function enhanced_image = process_image(input_image)

%% 1. Image Acquisition & Understanding
disp('--- Image Analysis ---');
if size(input_image,3) == 3
    gray = rgb2gray(input_image);
else
    gray = input_image;
end

fprintf('Resolution: %d x %d\n', size(gray,1), size(gray,2));
fprintf('Data Type: %s\n', class(gray));

figure;
imshow(gray);
title('Grayscale Image');

%% 2. Sampling & Quantization

figure;
subplot(2,3,1); imshow(imresize(gray,0.5)); title('0.5x');
subplot(2,3,2); imshow(imresize(gray,0.25)); title('0.25x');
subplot(2,3,3); imshow(gray); title('Original');
subplot(2,3,4); imshow(imresize(gray,1.5)); title('1.5x');
subplot(2,3,5); imshow(imresize(gray,2)); title('2x');

% Quantization
q8 = gray;
q4 = uint8(floor(double(gray)/16)*16);
q2 = uint8(floor(double(gray)/64)*64);

figure;
subplot(1,3,1); imshow(q8); title('8-bit');
subplot(1,3,2); imshow(q4); title('4-bit');
subplot(1,3,3); imshow(q2); title('2-bit');

%% 3. Geometric Transformations

figure;
angles = [30 45 60 90 120 150 180];
for i = 1:length(angles)
    subplot(2,4,i);
    imshow(imrotate(gray, angles(i)));
    title(['Rotate ' num2str(angles(i))]);
end

% Translation
translated = imtranslate(gray, [50 30]);

% Shearing
tform = affine2d([1 0.3 0; 0.3 1 0; 0 0 1]);
sheared = imwarp(gray, tform);

figure;
subplot(1,2,1); imshow(translated); title('Translated');
subplot(1,2,2); imshow(sheared); title('Sheared');

%% 4. Intensity Transformations

% Negative
negative = imcomplement(gray);

% Log Transformation
log_img = uint8(255 * log(1 + double(gray)) / log(256));

% Gamma Correction
gamma1 = imadjust(gray, [], [], 0.5);
gamma2 = imadjust(gray, [], [], 1.5);

figure;
subplot(2,2,1); imshow(negative); title('Negative');
subplot(2,2,2); imshow(log_img); title('Log');
subplot(2,2,3); imshow(gamma1); title('Gamma 0.5');
subplot(2,2,4); imshow(gamma2); title('Gamma 1.5');

%% 5. Histogram Processing

figure;
subplot(2,2,1); imhist(gray); title('Original Histogram');

equalized = histeq(gray);

subplot(2,2,2); imshow(gray); title('Original Image');
subplot(2,2,3); imhist(equalized); title('Equalized Histogram');
subplot(2,2,4); imshow(equalized); title('Equalized Image');

%% 6. Final Enhancement Selection

% Best pipeline (you can justify this in report)
enhanced_image = imadjust(equalized, [], [], 0.8);

end
