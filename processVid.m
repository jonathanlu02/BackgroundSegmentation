% processes .mov files into a matlab matrix that contains pixel width,
% height, rgb scale, and frame number.
function vidFrames = processVid(vid)

obj = VideoReader(vid);
vidFrames = read(obj);
numFrames = get(obj,'numberOfFrames');
for k = 1:numFrames
    mov(k).cdata = vidFrames(:,:,:,k);
    mov(k).colormap = [];
end
% for j = 1:numFrames
%     Z=frame2im(mov(j));
%     imshow(Z); drawnow
% end