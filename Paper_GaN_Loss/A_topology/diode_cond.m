function Vf = diode_cond(If )

if (0<=If) && (If<0.44)
    Vf=(0)/(0.44)*If;
end

if (0.44<=If) && (If<2.42)
    Vf=(0.62-0.39)/(2.42-0.44)*If;
end

if (2.42<=If) && (If<8.15)
     Vf=(0.87-0.62)/(8.15-2.42)*If;
end

if (8.15<=If) && (If<19.8)
     Vf=(1.15-0.87)/(19.8-8.15)*If;
end

if (19.8<=If) && (If<50)
     Vf=(1.65-1.15)/(50-19.8)*If;
end


end

