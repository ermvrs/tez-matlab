

function y=xxcfonk(t, q_in, V_liq, Xxc, x13, rho, sumrho)
    global if10;

    global if30;
    
    if10 = 0;
    if30 = 0;
    if (t >= 10)
        if(t >= 30 && if30 == 0)
            if30 = 1;
            disp('if30')
            y = (q_in/V_liq) * (2*Xxc - x13) - rho + sumrho;
        elseif(if10 == 0)
            if10 = 1;
            disp('if10')
            y = (q_in/V_liq) * (1.5*Xxc - x13) - rho + sumrho;
        else
            y = (q_in/V_liq) * (Xxc - x13) - rho + sumrho;
        end
    else
        y = (q_in/V_liq) * (Xxc - x13) - rho + sumrho;
    end
