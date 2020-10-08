function fn = made_monotonic(f)

fn=f;
for nn=2:length(fn)
    if(fn(nn)<=fn(nn-1))
        if abs(fn(nn-1))>1e-14
            fn(nn)=fn(nn-1)+1.0e-14;
        elseif fn(nn-1)==0
            fn(nn)= 1e-80;
        else
            fn(nn)=fn(nn-1)+10^(log10(abs(fn(nn-1))));
        end
    end
end
