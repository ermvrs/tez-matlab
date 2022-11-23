%------------------------------------------------------------------------%
% MATLAB IMPLEMENTATION OF ADM-1 
% SOLID STATE Modification for LBR

function dX=adm1sys(t,X)

global Ssu Saa Sfa Sva Sbu Spro Sac Sh2 Sch4 SIC SIN SI...
    Xxc Xch Xpr Xli...
    Xsu Xaa Xfa  Xc4 Xpro Xac Xh2 ...
    XI Scat San Shva Shbu Shpro Shac Shco3 Snh3 S_H_ion...
    S_gas_h2 S_gas_ch4  S_gas_co2...
    f_sI_xc f_xI_xc f_ch_xc f_pr_xc f_li_xc...
    N_xc  N_I  N_aa  C_xc C_sI  C_ch C_pr C_li C_xI  C_su  C_aa...
    f_fa_li C_fa   N_bac  C_bu  C_pro C_ac  C_bac... 
    Y_su  f_h2_aa  f_va_aa f_bu_aa  f_pro_aa f_ac_aa  C_va Y_aa Y_fa Y_c4 Y_pro C_ch4 Y_ac Y_h2 Y_ce...
    k_dis k_hyd_ch  k_hyd_pr  k_hyd_li  K_S_IN k_m_su...
    K_S_su pH_UL_aa pH_LL_aa  k_m_aa  K_S_aa k_m_fa  K_S_fa   k_m_c4 K_S_c4  k_m_pro... 
    K_S_pro  k_m_ac K_S_ac K_I_nh3 pH_UL_ac  pH_LL_ac k_m_h2  K_S_h2 pH_UL_h2 pH_LL_h2... 
    k_dec_Xsu k_dec_Xaa k_dec_Xfa k_dec_Xc4 k_dec_Xpro k_dec_Xac k_dec_Xh2...
    R  T_op K_w K_a_va K_a_bu K_a_pro K_a_ac K_a_co2 K_a_IN k_A_Bva k_A_Bbu k_A_Bpro k_A_Bac... 
    k_A_Bco2 k_A_BIN kLa K_H_co2 K_H_ch4 K_H_h2... 
    q_in V_liq  V_gas P_atm p_gas_h2o  kp q_gas  K_I_vfach4...
    f_su_h2 f_su_bu f_su_pro f_su_ac  f_fa_ac f_val_pro f_but_ac f_val_ac f_su_lac...
    f_pro_ac f_fa_h2 f_but_h2 f_val_h2 f_pro_h2 ...
    delG_1 delG_2 delG_3 delG_4 delG_5 delG_6 delG_7...
    Ith_glu_ace_h2 Ith_glu_pro Ith_glu_but Ith_fa_ace Ith_val_ace_pro...
    Ith_pro_ace Ith_but_ace Ith_h2toace...
    delG_glutoAA delG_glutoBA delG_glutoPA delG_FAtoAA  delG_VAtoPA delG_H2toAce ...
    delG_BAtoAA  delG_PAtoAA  R_inh MW_ace COD_ace  ...
    MW_glu COD_glu COD_fa MW_fa MW_va COD_va MW_bu COD_bu MW_pro COD_pro...
    k_m_homo K_S_homo k_dec_Xhomo Y_homo Xhomo ...
    n1_su n2_su...
    I_comp k_m_ce K_S_CE k_dec_Xce Slac  f_h2_lac  XCE......
    Sca f_ca_lac n3_su n4_su...
    % WATER PHASE
    
    % S_H+ calculation 
 	Phi = X(25) + (X(11)-X(32)) - X(31) - X(30)/64 - X(29)/112 - X(28)/160 - X(27)/208 - X(26)-X(40)/96;
    
    % S_H+ Calculation
    % (Alternative pH Calc Expression)  S_H_ion = -Phi * 0.5 + 0.5 * sqrt(Phi * Phi + 4.0 * K_w);
    S_H_ion = - (Phi / 2) + (((Phi^2 + 4 * K_w)^(0.5)) / 2);
    pH_op = -log10(S_H_ion);   % Operating pH of system - Calculate Operating pH from S_H_ion concentration
   
 	dX(33) = S_H_ion - X(33);

	% pH Inhibition:
	pH=-log10(X(33)); % calculate pH from S_H+
 
    % Alternative pH expressions based on Siegrist et al, 2002 with Hill
    % function Rosen and Jeppson 2008
    %naa=3/(pH_UL_aa-pH_LL_aa);
    %nac=3/(pH_UL_ac-pH_LL_ac);
    %nh2=3/(pH_UL_h2-pH_LL_h2);
    
    %KpH_aa=10^(-(pH_LL_aa+pH_UL_aa)/2);
   % KpH_ac=10^(-(pH_LL_ac+pH_UL_ac)/2);
    %KpH_h2=10^(-(pH_LL_h2+pH_UL_h2)/2);
    
    %I_pH_aa= (KpH_aa^naa)/(S_H_ion^naa+KpH_aa^naa);
    %I_pH_ac= 1; % (KpH_ac^nac)/(S_H_ion^nac+KpH_ac^nac);
    %I_pH_h2= (KpH_h2^nh2)/(S_H_ion^nh2+KpH_h2^nh2);
    
    
   % Batstone lower pH inhibition calculations 

    if pH < pH_UL_aa
		I_pH_aa = exp(-3*((pH - pH_UL_aa)/(pH_UL_aa - pH_LL_aa))^2);
    else
		I_pH_aa = 1;
    end
	if pH < pH_UL_ac
		I_pH_ac = exp(-3*((pH - pH_UL_ac)/(pH_UL_ac - pH_LL_ac))^2);
    else
		I_pH_ac = 1;
    end
	if pH < pH_UL_h2
		I_pH_h2 = exp(-3*((pH - pH_UL_h2)/(pH_UL_h2 - pH_LL_h2))^2);
    else
		I_pH_h2 = 1;
   end
	
   
  
                  
    % Inhibition Effect Calculations
    % ------------------------------------------------------
    I_IN_lim = 1 / (1 + K_S_IN / X(11));    %K_S_IN
    %I_h2_fa = 1 /(1 + X(8) / K_Ih2_fa);
   % I_h2_c4 = 1 / (1 + X(8) / K_Ih2_c4);
    %I_h2_pro = 1 / (1 + X(8) / K_Ih2_pro);
    I_h2_nh3 = 1 / (1 + X(32) / K_I_nh3);
    Ivfa_ch4 =1 / (1 + ((X(4)+X(5)+X(6)+X(7)) / K_I_vfach4));%methanogens

    
    I5 = I_pH_aa * I_IN_lim;
	I6 = I_pH_aa * I_IN_lim;
	I7 = I_pH_aa * I_IN_lim ;
	I8 = I_pH_aa * I_IN_lim ;
	I9 = I_pH_aa * I_IN_lim ;
	I10 =I_pH_aa * I_IN_lim ;
	I11 = I_pH_ac * I_IN_lim * I_h2_nh3 * Ivfa_ch4 ;
	I12 = I_pH_h2 * I_IN_lim* Ivfa_ch4;
    I13 = I_pH_ac * I_IN_lim; %hmoacetogen inhibition
    I_comp= 1;%(X(40)/(X(1)+X(40)+1e-6)); %Nascimento et al 2022, BITE reports Chain elongation based on lactic acid concentration
    
   
    %---------------------------------------------------------------------
 
	% Acid - base rates (X(33) = S_H+)
    rhoA4 = k_A_Bva*(X(27) * (K_a_va + X(33)) - K_a_va*X(4));
	rhoA5 = k_A_Bbu*(X(28) * (K_a_bu + X(33)) - K_a_bu*X(5));
	rhoA6 = k_A_Bpro*(X(29) * (K_a_pro + X(33)) - K_a_pro*X(6));
	rhoA7 = k_A_Bac*(X(30) * (K_a_ac + X(33)) - K_a_ac*X(7));
    rhoA10 = k_A_Bco2*(X(31) * (K_a_co2 + X(33)) - K_a_co2*X(10));
	rhoA11 = k_A_BIN*(X(32) * (K_a_IN + X(33)) - K_a_IN * X(11));

	% GAS PHASE CALCULATIONS (Algebraic Equations)
    % R Units: [bar m3/kmol K],   T_op Units: [K] it affects only the total gas flow but not the relation between components in the gas.
	p_gas_h2 = X(34) * R * T_op/16;  % [bar] (16 kg-COD/kmol H2).
   
	p_gas_ch4 = X(35) * R * T_op/64; % [bar] (64 kg-COD/kmol CH4).
   
	p_gas_co2 = X(36) * R * T_op;    % [bar] (no COD value for CO2 - completely oxidized form).
   % 1: glucose to acetate and hydrogen, 2: glocuse to propionate
   %3 glucose to butyrate 4: LCFA to Acetate, 5: Va to acetate and
   %propionate, 6 butyrate to acetate, 7: propionate to acetate
       
   
  if p_gas_h2<0.0006
      n1_su=0.5;%0.52;
      n2_su=0.02;
      n3_su=0.05;%0.04;
      n4_su=0.43;%0.43;

   elseif p_gas_h2>=0.0006
      n1_su=0.01;%0.08;
      n2_su=0.04;%0.02;
      n3_su=0.88;%0.9;
      n4_su=0.07;
   end
  
    f_su_h2 = 0.33*n1_su+0.17*(1-n2_su-n1_su);
    f_su_bu = 0.83*(1-n2_su-n1_su);
    f_su_pro = 0.78*n2_su;
    f_su_ac =  0.67*n1_su+0.22*n2_su;
    f_su_lac = 1*n4_su;

    
   delG_1=(delG_glutoAA*1000) + R_inh*T_op*log((((X(7)/(COD_ace*MW_ace))^2)*(p_gas_h2^4)*(p_gas_co2)^2)/((X(1)/(COD_glu*MW_glu))*1));
   delG_2=(delG_glutoPA*1000) + R_inh*T_op*log((((X(6)/(COD_pro*MW_pro))^2))/((X(1)/(COD_glu*MW_glu))*(p_gas_h2^2)));
   delG_3=(delG_glutoBA*1000) + R_inh*T_op*log((((X(5)/(COD_bu*MW_bu)))*(p_gas_h2^2)*(p_gas_co2)^2)/((X(1)/(COD_glu*MW_glu))*1));
   
   delG_4=(delG_FAtoAA*1000) + R_inh*T_op*log((((X(7)/(COD_ace*MW_ace))^8)*(p_gas_h2^14))/((X(3)/(COD_fa*MW_fa))*1));
   
   delG_5=(delG_VAtoPA*1000) + R_inh*T_op*log((((X(7)/(COD_ace*MW_ace)))*(X(6)/(COD_pro*MW_pro))*(p_gas_h2)^2)/((X(4)/(COD_va*MW_va))*1));
   
   delG_6=(delG_BAtoAA*1000) + R_inh*T_op*log((((X(7)/(COD_ace*MW_ace))^2)*(p_gas_h2^2))/((X(5)/(COD_bu*MW_bu))));
   
   delG_7=(delG_PAtoAA*1000) + R_inh*T_op*log((((X(7)/(COD_ace*MW_ace)))*(p_gas_h2^3)*(p_gas_co2))/((X(6)/(COD_pro*MW_pro))));
   
   delG_8=(delG_H2toAce*1000) + R_inh*T_op*log((((X(7)/(COD_ace*MW_ace))^2))/((p_gas_h2^4)*(p_gas_co2^2)));
   
 
   
   if (delG_1/1000)<0
       Ith_glu_ace_h2=1-((delG_1/1000)/(R_inh*T_op));
   else
       Ith_glu_ace_h2=0;
   end
   
   if (delG_2/1000)<0
       Ith_glu_pro=1-((delG_2/1000)/(R_inh*T_op));
   else
       Ith_glu_pro=0;
   end
   
    if (delG_3/1000)<0
       Ith_glu_but=1-((delG_3/1000)/(R_inh*T_op));
    else
       Ith_glu_but=0;
    end
   
        if (delG_4/1000)<0
          Ith_fa_ace=1-((delG_4/1000)/(R_inh*T_op));
        else
             Ith_fa_ace=0;
        end
   
               if (delG_5/1000)<0
                    Ith_val_ace_pro=1-((delG_5/1000)/(R_inh*T_op));
               else
                    Ith_val_ace_pro=0;
               end
               
                              if (delG_6/1000)<0
                                 Ith_but_ace=1;%1-((delG_6/1000)/(R_inh*T_op));
                              else
                                 Ith_but_ace=0;
                              end
   
                  if (delG_7/1000)<0
                    Ith_pro_ace=1-((delG_7/1000)/(R_inh*T_op));
                  else
                    Ith_pro_ace=0;
                  end
 
                    if (delG_8/1000)<0
                     Ith_h2toace=1-((delG_8/1000)/(R_inh*T_op));
                    else
                     Ith_h2toace=0;
                    end

      % Process Reaction Rate Calculations:
	rho(1) = k_dis * X(13);
	rho(2) = k_hyd_ch * X(14);
	rho(3) = k_hyd_pr * X(15);
	rho(4) = k_hyd_li * X(16);
    
	
	rho(5) = k_m_su * (X(1)/(K_S_su + X(1))) * X(17)*I5*Ith_glu_ace_h2;
	rho(6) = k_m_aa * (X(2)/(K_S_aa + X(2))) * X(18)*I6; 
	rho(7) = k_m_fa * (X(3)/(K_S_fa + X(3))) * X(19)*I7*Ith_fa_ace; 
	
    rho(8) = k_m_c4 * (X(4)/(K_S_c4 + X(4))) * (X(4)/(X(4) + X(5) + 1e-6)) * (X(20)*I8)*Ith_val_ace_pro;
	rho(9) = k_m_c4 * (X(5)/(K_S_c4 + X(5))) * (X(5)/(X(5) + X(4) + 1e-6)) * (X(20)*I9)*Ith_but_ace;
    rho(10) = k_m_pro * (X(6)/(K_S_pro + X(6))) * ((X(21)*I10))*Ith_pro_ace;
    rho(11) = k_m_ac * (X(7)/(K_S_ac + X(7))) * X(22) * I11; 
	rho(12) = k_m_h2 * (X(8)/(K_S_h2 + X(8))) * X(23) * I12; 
    rho(20)= k_m_homo*(X(8)/(K_S_homo + X(8)))*X(38)*I13*Ith_h2toace;
  
    rho(22)=k_m_ce * (X(40)/(K_S_CE + X(40))) * X(39) * I5 * I_comp; %Chain Elongation
    
    disp(Ith_h2toace);
	rho(13) = k_dec_Xsu * X(17);
	rho(14) = k_dec_Xaa * X(18);
	rho(15) = k_dec_Xfa * X(19);
	rho(16) = k_dec_Xc4 * X(20);
	rho(17) = k_dec_Xpro * X(21);
	rho(18) = k_dec_Xac * X(22);
	rho(19) = k_dec_Xh2 * X(23);
    rho(21) = k_dec_Xhomo * X(38);
    rho(23) = k_dec_Xce * X(39);
                  

     
	% Gas transfer rates 
	rhoT8 = kLa * (X(8) - 16 * K_H_h2 * p_gas_h2); 
	rhoT9 = kLa * (X(9) - 64 * K_H_ch4*p_gas_ch4); 
	rhoT10 = kLa * (X(10) - X(31) - K_H_co2 * p_gas_co2);
    

	% Algebraic equations 
	%q_gas = ((R * T_op) / (P_atm - p_gas_h2o)) * V_liq * (rhoT8/16 + rhoT9/64 + rhoT10);
	%q_gas=max(q_gas,0);
     
   % Alternative qgas calculation described by Batstone
     p_gas=p_gas_h2+p_gas_ch4+p_gas_co2+p_gas_h2o;
     q_gas=kp*(p_gas-P_atm)*(p_gas/P_atm);
     
       
     % Stoichiometric Calculations:
    Cvsum1 = (-C_xc + f_sI_xc*C_sI + f_ch_xc*C_ch + f_pr_xc*C_pr + f_li_xc*C_li + f_xI_xc*C_xI);
    Cvsum2 = (-C_ch + C_su);
    Cvsum3 = (-C_pr + C_aa);
    Cvsum4 = (-C_li + (1-f_fa_li) * C_su + f_fa_li * C_fa);
    Cvsum5 = (-C_su + (1 - Y_su) * (f_su_bu*C_bu + f_su_pro * C_pro + f_su_ac * C_ac) +Y_su * C_bac);
    Cvsum6 = (-C_aa + (1 - Y_aa) * (f_va_aa * C_va + f_bu_aa * C_bu + f_pro_aa * C_pro + f_ac_aa * C_ac) + Y_aa * C_bac);
    Cvsum7 = (-C_fa + (1 - Y_fa) * 0.7 * C_ac + Y_fa * C_bac);
    Cvsum8 = (-C_va + (1 - Y_c4) * 0.54 * C_pro + (1 - Y_c4) * 0.31 * C_ac + Y_c4 * C_bac);
    Cvsum9 = (-C_bu + (1 - Y_c4) * 0.8 * C_ac + Y_c4 * C_bac);
    Cvsum10 = (-C_pro + (1 - Y_pro) * 0.57 * C_ac + Y_pro * C_bac);
    Cvsum11 = (-C_ac + (1 - Y_ac) * C_ch4 + Y_ac * C_bac);
    Cvsum12 = ( (1 - Y_h2) * C_ch4 + Y_h2 * C_bac);
    Cvsum13_19 = (-C_bac + C_xc);
    
	% Precalculation of term in equation for state 10 (S_IC)
	sumproc = Cvsum1*rho(1) + Cvsum2*rho(2) + Cvsum3*rho(3) + Cvsum4*rho(4) +...
        Cvsum5*rho(5) + Cvsum6*rho(6) + Cvsum7*rho(7) + Cvsum8*rho(8) + Cvsum9*rho(9) +...
        Cvsum10*rho(10) + Cvsum11*rho(11) + Cvsum12*rho(12)+ Cvsum13_19*sum(rho(13:19));

    % Bioreactor Mass Balance Calculations
    % [Based on ADM1 Model Mass Balance Definitions]
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Differential equations (soluble matter):
    % -----------------------------------------------------------------
    % Mass Balance Eqn for Monosaccharides
	dX(1) = (q_in/V_liq) * (Ssu - X(1)) + rho(2) + (1 - f_fa_li) * (rho(4)) - rho(5);
    
    % Mass Balance Eqn for Amino Acids
    dX(2) = (q_in/V_liq) * (Saa - X(2)) + rho(3)  - rho(6);
    
    % Mass Balance Eqn for Total Long Chain Fatty Acids (LCFA)
    dX(3) = (q_in/V_liq) * (Sfa - X(3)) + f_fa_li * (rho(4)) - rho(7);
    
    % Mass Balance Eqn for  Lactic acid 
    dX(40) = (q_in/V_liq) * (Slac - X(40)) + (1 - Y_su) * f_su_lac*rho(5)-rho(22);
    
    
    % Mass Balance Eqn for  Caproic acid 
    dX(41) = (q_in/V_liq) * (Sca - X(41)) + (1 - Y_ce) * f_ca_lac*rho(22); 
    
    
    % Mass Balance Eqn for Total Valerate
    dX(4) = (q_in/V_liq) * (Sva - X(4)) + (1 - Y_aa) * f_va_aa*rho(6) - rho(8) ;
    
    % Mass Balance Eqn for Total Butyrate
	dX(5) = (q_in/V_liq) * (Sbu - X(5)) +(1 - Y_su) * f_su_bu * rho(5) + (1 - Y_aa) * f_bu_aa * rho(6) - rho(9);
    
    % Mass Balance Eqn for Total Propionate
	%dX(6) = (q_in/V_liq) * (Spro - X(6)) + (1 - Y_su) * f_pro_su * rho(5)*IpartialH2 + (1 - Y_aa) * f_pro_aa * rho(6) + (1 - Y_c4) * 0.54 * rho(8) - rho(10);
    dX(6) = (q_in/V_liq) * (Spro - X(6)) + (1 - Y_su) * f_su_pro * rho(5) + (1 - Y_aa) * f_pro_aa * rho(6) + (1 - Y_c4) * f_val_pro * rho(8) - rho(10);
    
    % Mass Balance Eqn for Total Acetate

	dX(7) = (q_in/V_liq) * (Sac - X(7)) + (1 - Y_su) * f_su_ac * rho(5) + (1 - Y_aa) * f_ac_aa * rho(6) + (1 - Y_fa)*f_fa_ac * rho(7) + (1 - Y_c4) * f_but_ac * rho(9)+...
    (1-Y_c4) * f_val_ac * rho(8)  +(1 - Y_pro) * f_pro_ac * rho(10) + (1-Y_homo)*1*rho(20) - rho(11);
    
    % Mass Balance Eqn for Hydrogen
    
	dX(8) = (q_in/V_liq) * (Sh2 - X(8)) + (1 - Y_su) * f_su_h2 * rho(5) + (1 - Y_aa) * f_h2_aa * rho(6) + (1 - Y_fa) * f_fa_h2 * rho(7) + (1 - Y_ce) * f_h2_lac* rho(22)+...
    (1 - Y_c4) * f_but_h2* rho(9) + (1-Y_c4) * f_val_h2 * rho(8)+ (1 - Y_pro) * f_pro_h2 * rho(10) - rho(12) - rhoT8-rho(20);

    % Mass Balance Eqn for Methane	
	dX(9) = (q_in/V_liq) * (Sch4 - X(9)) + (1 - Y_ac) * rho(11) + (1 - Y_h2) * rho(12) - rhoT9; 
    
    % Mass Balance Eqn for Inorganic Carbon

    dX(10) = (q_in/V_liq) * (SIC - X(10)) - sumproc - rhoT10; 
    
    % Mass Balance Eqn for Inorganic Nitrogen
    dX(11) = (q_in/V_liq) * (SIN - X(11)) - Y_su * N_bac * rho(5) +(N_aa - Y_aa * N_bac) * rho(6) - Y_fa * N_bac * rho(7) - ...
	Y_c4 * N_bac * rho(8) - Y_c4 * N_bac * rho(9) - Y_pro * N_bac * rho(10) - Y_ac * N_bac * rho(11) - ...
	Y_h2 * N_bac * rho(12) + (N_bac - N_xc) * sum(rho(13:19)) + (N_xc - f_xI_xc * N_I - f_sI_xc * N_I - f_pr_xc * N_aa) * rho(1);
    
    % Mass Balance Eqn for Soluble Inerts
	dX(12) = (q_in/V_liq) * (SI - X(12)) + f_sI_xc * rho(1); 
	
    % Differential equations (particulate matter):
    % -----------------------------------------------------------------
    % Mass Balance Eqn for Composite	
    dX(13) = (q_in/V_liq) * (Xxc - X(13)) - rho(1) + sum(rho(13:19));
    % Mass Balance Eqn for Carbohydrates
	dX(14) = (q_in/V_liq) * (Xch - X(14)) + f_ch_xc * rho(1) - rho(2);
  %  dX(37) = (q_in/V_liq) * (X_ch_feed - X(37)) - rho(21);
    % Mass Balance Eqn for Proteins
	dX(15) = (q_in/V_liq) * (Xpr - X(15)) + f_pr_xc * rho(1) - rho(3);
   % dX(38) = (q_in/V_liq) * (X_pr_feed - X(38)) - rho(22);
    % Mass Balance Eqn for Lipids
	dX(16) = (q_in/V_liq) * (Xli - X(16)) + f_li_xc * rho(1) - rho(4);
  %  dX(39) = (q_in/V_liq) * (X_li_feed - X(39)) - rho(23);
    % Mass Balance Eqn for Biomass (Monosaccharides)	
	dX(17) = (q_in/V_liq) * (Xsu - X(17)) + Y_su * rho(5)*(1-((X(4)+X(5)+X(6)+X(7))/20)) - rho(13); % Kim et al BEJ_2016 VFA Ýnhibition function
    % Mass Balance Eqn for Biomass (Amino Acids)
	dX(18) = (q_in/V_liq) * (Xaa - X(18)) + Y_aa * rho(6) - rho(14);
    % Mass Balance Eqn for Biomass (Long Chain Fatty Acids)
	dX(19) = (q_in/V_liq) * (Xfa - X(19)) + Y_fa * rho(7) - rho(15);
    
    % Mass Balance Eqn for Biomass (Valerate & Butyrate Combined)
   
   
	dX(20) = (q_in/V_liq) * (Xc4 - X(20)) + Y_c4 * rho(8) + Y_c4 * rho(9)- rho(16);

    % Mass Balance Eqn for Biomass (Propionate)	

    %disp(Xsu); 
	dX(21) = (q_in/V_liq) * (Xpro - X(21)) + Y_pro * rho(10)- rho(17);

    % Mass Balance Eqn for Biomass (Acetate)
	dX(22) = (q_in/V_liq) * (Xac - X(22)) + Y_ac * rho(11) - rho(18);
    % Mass Balance Eqn for Biomass (Hydrogen)
	dX(23) = (q_in/V_liq) * (Xh2 - X(23)) + Y_h2 * rho(12) - rho(19); 
   % Mass Balance Eqn for Biomass (Homoacetogens)
	dX(38) = (q_in/V_liq) * (Xhomo - X(38)) + Y_homo * rho(20) - rho(21);
    % Mass Balance Eqn for Biomass (Chain Elongation)
	dX(39) = (q_in/V_liq) * (XCE - X(39)) + Y_ce * rho(22) - rho(23);
    % Mass Balance Eqn for Particulate Inerts
	dX(24) = (q_in/V_liq) * (XI - X(24)) + f_xI_xc * rho(1);
	
    % Differential equations (Cations / Anions):
    % -----------------------------------------------------------------
    % Mass Balance Eqn for Cations
 	dX(25) = (q_in/V_liq) * (Scat - X(25));
    % Mass Balance Eqn for Anions
 	dX(26) = (q_in/V_liq) * (San - X(26));
	
	% Additional Differential Equation States
 	dX(27) = - rhoA4; 
 	dX(28) = - rhoA5; 
 	dX(29) = - rhoA6; 
 	dX(30) = - rhoA7; 
	dX(31) = - rhoA10;
	dX(32) = - rhoA11; 
    
	
	% Gas Differential equations
	dX(34) = -((X(34) * q_gas) / V_gas) + rhoT8 * (V_liq/V_gas);
	dX(35) = -((X(35) * q_gas) / V_gas) + rhoT9 * (V_liq/V_gas);
	dX(36) = -((X(36) * q_gas) / V_gas) + rhoT10 * (V_liq/V_gas);
    dX(37)= q_gas;
  
    % Load Current State Vector Array (X0) with Initial Reactor State Configuration Variables
    X0(1) = Ssu;   % Monosaccharides
    X0(2) = Saa;   % Amino Acids
    X0(3) = Sfa;   % Total Long Chain Fatty Acids (LCFA)
    X0(4) = Sva;   % Total Valerate
    X0(5) = Sbu;   % Total Butyrate
    X0(6) = Spro;  % Total Propionate
    X0(7) = Sac;   % Total Acetate
    X0(8) = Sh2;   % Hydrogen
    X0(9) = Sch4;  % Methane
    X0(10) = SIC;  % Inorganic Carbon
    X0(11) = SIN;  % Inorganic Nitrogen
    X0(12) = SI;   % Soluble Inerts
    X0(13) = Xxc;  % Composite
    X0(14) = Xch;  % Carbohydrates
    X0(15) = Xpr;  % Proteins
    X0(16) = Xli;  % Lipids
    X0(17) = Xsu;  % Biomass (Monosaccharides)
    X0(18) = Xaa;  % Biomass (Amino Acids)
    X0(19) = Xfa;  % Biomass (Long Chain Fatty Acids)
    X0(20) = Xc4;  % Biomass (Valerate & Butyrate Combined)
    X0(21) = Xpro; % Biomass (Propionate)
    X0(22) = Xac;  % Biomass (Acetate)
    X0(23) = Xh2;  % Biomass (Hydrogen)
    X0(24) = XI;   % Particulate Inerts
    X0(25) = Scat; % Cations
    X0(26) = San;  % Anions
    X0(27) = Shva; %  
    X0(28) = Shbu; %  
    X0(29) = Shpro; %  
    X0(30) = Shac;  %  
    X0(31) = Shco3; % 
    X0(32) = Snh3;  %
    X0(33) = S_H_ion;   %

    % Reactor Operation Variables
    X0(34) = S_gas_h2;  % 
    X0(35) = S_gas_ch4; % 
    X0(36) = S_gas_co2; % 
    X0(37)=q_gas;
    X0(38)=Xhomo; %Biomass (Homoacetogens)
    X0(39)=XCE; %Chain elongation bacteria
    X0(40)=Slac;%Lactic acid
    X0(41)=Sca;% Caproic acid
    %feed extension
  %  X0(37) = X_ch_feed;
  %  X0(38) = X_pr_feed;
  %  X0(39) = X_li_feed;


   

  dX=dX(:);

% ---- End ADM1 Program ---------------------------------