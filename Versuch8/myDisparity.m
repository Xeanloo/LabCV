function D = myDisparity(imgLeft, imgRight, maxDisparity, windowSize)
    
    imgSize = size(imgLeft);
    D = zeros(imgSize(1), imgSize(2), maxDisparity);
    SAD = zeros(imgSize(1), imgSize(2), maxDisparity);
    SSD = zeros(imgSize(1), imgSize(2), maxDisparity);
    NCC = zeros(imgSize(1), imgSize(2), maxDisparity);
    rightShiftFilter = [0, 0, 1];
    imgRightShifted = imgRight;
    for d = 1:maxDisparity
        imgRightShifted = conv2(imgRightShifted, rightShiftFilter);
        imgRightShifted = imgRightShifted(:, 2:end-1);
        D(:, :, d) = abs(imgLeft - imgRightShifted);
        if windowSize > 1
            SAD(:, :, d) = conv2(D(:, :, d), ones(windowSize), 'same');
            SSD(:, :, d) = conv2(D(:, :, d).^2, ones(windowSize), 'same');
            conv_imgLeft = conv2(imgLeft, ones(windowSize), 'same')./ (windowSize^2);
            conv_imgRightShifted = conv2(imgRightShifted, ones(windowSize), 'same')./ (windowSize^2);

            num_NCC = conv2((imgLeft - conv_imgLeft) .* (imgRightShifted - conv_imgRightShifted), ones(windowSize), 'same').^2;
            den_NCC = conv2((imgLeft - conv_imgLeft).^2, ones(windowSize), 'same') .* conv2((imgRightShifted - conv_imgRightShifted).^2, ones(windowSize), 'same');
            NCC(:, :, d) = ones(size(num_NCC)) - (num_NCC ./ den_NCC);
        end
    end
    if windowSize > 1
        [~, SAD] = min(SAD, [], 3);
        figure(4); clf;
        imagesc(SAD); colormap(gray); axis image; title('SAD Disparity Map');
        [~, SSD] = min(SSD, [], 3);
        figure(5); clf;
        imagesc(SSD); colormap(gray); axis image; title('SSD Disparity Map');
        [~, NCC] = min(NCC, [], 3);
        D = NCC; 
    else
        [~, D] = min(D, [], 3);
    end
end