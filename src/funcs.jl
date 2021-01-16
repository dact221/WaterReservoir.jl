function _linear_interpolation(n, x, y, xᵢ)
    i = 0
    if xᵢ >= x[n-1]
        i = n - 1
    else
        while xᵢ > x[i+1]
            i += 1
        end
    end
    m = (y[i+1] - y[i]) / (x[i+1] - x[i])
    return y[i] + m * (xᵢ - x[i])
end
