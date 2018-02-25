function Err = diode_sw(Id)
If=-Id;
if (0<=If) && (If<3.8)
    Err=(0.83)/(3.8)*If;
end

if (3.8<=If) && (If<20)
    Err=(2.1-0.833)/(20-3.8)*If;
end

if (20<=Id) && (If<35)
     Err=(3-2.15)/(35-20)*If;
end

if (35<=Id) && (If<54.5)
     Err=(3.74-3)/(54.5-35)*If;
end

end

