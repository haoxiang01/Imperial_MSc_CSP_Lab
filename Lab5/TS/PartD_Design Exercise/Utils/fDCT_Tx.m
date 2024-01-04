function K = fDCT_Tx(I, blockSize, compressedRatio)
   
    [rows, cols] = size(I);
    K = zeros(rows, cols);
    
    % Calculate the number of coefficients to keep based on the compressed ratio
    numCoefficients = blockSize * blockSize / compressedRatio;
    numCoefficientsPerDimension = sqrt(numCoefficients);

    for i = 1:blockSize:rows
        for j = 1:blockSize:cols
            % Extract the block
            block = I(i:min(i+blockSize-1, rows), j:min(j+blockSize-1, cols));

            % Apply DCT
            J = dct2(block);

            % Zero out all but the top left 'numCoefficientsPerDimension x numCoefficientsPerDimension' coefficients
            J(numCoefficientsPerDimension+1:end, :) = 0;
            J(:, numCoefficientsPerDimension+1:end) = 0;

            % Replace the block in the compressed image
            K(i:min(i+blockSize-1, rows), j:min(j+blockSize-1, cols)) = J;
        end
    end