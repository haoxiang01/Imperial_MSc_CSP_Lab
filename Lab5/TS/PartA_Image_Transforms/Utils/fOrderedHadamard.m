function orderedH = fOrderedHadamard(H)
    % Define a kernel to detect zero-crossings
    kernel = [0, 0, 0; 0, 1, -1; 0, 0, 0];

    % Compute the zero-crossings using convolution
    zeroCrossing = abs(conv2(H, kernel, 'same'));

    % Modify zeroCrossing matrix to retain only the values equal to 2
    zeroCrossing(zeroCrossing ~= 2) = 0;

    % Sort the rows based on the number of zero-crossings
    [~, I] = sort(sum(zeroCrossing, 2) / 2);

    % Reorder the Hadamard matrix based on the zero-crossings
    orderedH = H(I, :);
end