function result= Quantization(x)
    r = real(x);
    i = imag(x);
    
    if r >= 0
        bit_1 = 1;
    else
        bit_1 = -1;
    end
    
    if i >= 0
        bit_2 = 1;
    else
        bit_2 = -1;
    end

    result = bit_1+1i*bit_2;
end