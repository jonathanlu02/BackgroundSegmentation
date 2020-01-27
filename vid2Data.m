% turns the video matrix into readable data - returns A which holds pixels
% values in double precision, grayscaled, and reshaped, per frame
function A = vid2Data(vid)

numFrames = size(vid, 4);

%%  turn resulting 4-d video matrix to 3-d grayscale matrix (w,h,numFrames)
for k = numFrames:-1:1 % note: start backwards to initialize size of g
    g(:, :, k) = imresize(rgb2gray(vid(:, :, :, k)), 0.25);
end

A = [];

%% turn 3-d grayscale matrix into double precision, reshape to row vector,
% add to data matrix.
for k = numFrames:-1:1
    R = reshape(double(g(:,:,k)), [], 1);
    A = [A R];
end