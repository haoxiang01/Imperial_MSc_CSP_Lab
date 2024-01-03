% ML Detection with Alam Coding
% Returen ML estimated symbols
function ML_symbols_Alam = ML_Detection_Alam(Rx, M, H, num_symbols, nT)
    symbols = qammod(0:M-1, M, 'gray', 'UnitAveragePower', true); % corresponding QPSK symbols
    
    % The Kronecker product is used to generate all possible 2x2 MIMO symbol combinations (2x16 matrix).
    symbol_combinations = [kron(symbols, ones(size(symbols)))', kron(ones(size(symbols)), symbols)'];

    estimated_symbols = zeros(nT, num_symbols/nT);
    for i = 1:2:num_symbols  % We'll process two received symbols at a time due to Alamouti scheme
        y = Rx(:, i:i+1);
        min_distance = inf;
        best_combination = [0; 0];
        
        for j = 1:size(symbol_combinations, 1)
            x1 = symbol_combinations(j, 1);
            x2 = symbol_combinations(j, 2);
            
            x_ = [x1, -conj(x2); x2, conj(x1)];
            y_est = H * x_;
            
            distance = norm(y - y_est, 'fro')^2;
            
            if distance < min_distance
                min_distance = distance;
                best_combination = [x1; x2];
            end
        end
        
        estimated_symbols(:, ceil(i/2)) = best_combination; 
    end
    
    ML_symbols_Alam = reshape(estimated_symbols, [], 1);
end




