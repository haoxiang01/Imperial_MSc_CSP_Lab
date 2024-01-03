% ML Detection
% Returen ML estimated symbols
function ML_symbols = ML_Detection(Rx,M,H,num_symbols,nT)
    symbols = qammod(0:M-1, M, 'gray', 'UnitAveragePower', true);%corresponding QPSK symbols
    
    % The Kronecker product is used to generate all possible 2x2 MIMO symbol combinations(2*16 matrix).
    symbol_combinations = [kron(symbols, ones(size(symbols)))', kron(ones(size(symbols)), symbols)'];
    
    estimated_symbols = zeros(nT, num_symbols/nT);
    for i = 1:num_symbols/nT
        % Calculate the Euclidean distance
        distances = sum(abs(Rx(:, i) - H * symbol_combinations.').^2, 1);

        % Find the index of the smallest distance
        [~, idx] = min(distances);
        estimated_symbols(:, i) = symbol_combinations(idx, :).';
    end
    ML_symbols = estimated_symbols;
end