function K = fIDCT_Rx(J, blockSize)
    [rows, cols] = size(J);
    K = zeros(rows, cols);
    for i = 1:blockSize:rows
        for j = 1:blockSize:cols
            block = J(i:min(i+blockSize-1, rows), j:min(j+blockSize-1, cols));
            % Inverse DCT
            block = idct2(block);

            % Replace the block
            K(i:min(i+blockSize-1, rows), j:min(j+blockSize-1, cols)) = block;
        end
    end

    % Normalize the image
    K = mat2gray(K);
end