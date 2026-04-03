% Load Image
img = imread('/MATLAB Drive/family.jpg');   

% Call main processing function
enhanced_image = process_image(img);

% Show final output
figure;
imshow(enhanced_image);
title('Final Enhanced Image');
