% ADM1 variables initialization sets parameter values for the ADM1
% CSTR according to recommended values of Batstone, Rosen, Jeppsson, et. al.


% 2008_CONTINUOUS MODEL USED IN BB PAPER

global Ssu Saa Sfa Sva Sbu Spro Sac Sh2 Sch4 SIC SIN SI Xxc Xch Xpr Xli Xsu Xaa Xfa ... 
       Xc4 Xpro Xac Xh2 XI Scat San Shva Shbu Shpro Shac Shco3 Snh3 S_H_ion S_gas_h2 S_gas_ch4 S_gas_co2 ...
       Ssu_in Saa_in Sfa_in Sva_in Sbu_in Spro_in Sac_in Sh2_in Sch4_in SIC_in SIN_in SI_in Xxc_in Xch_in Xpr_in ...
       Xli_in Xsu_in Xaa_in Xfa_in Xc4_in Xpro_in Xac_in Xh2_in XI_in Scat_in San_in Phi X_H_temp q_in ...
       V_liq V_gas tres_x q_in tout time out DEBUG tempflag ...
       f_sI_xc f_xI_xc f_ch_xc f_pr_xc f_li_xc N_xc N_I f_fa_li f_h2_su...
 	   f_bu_su f_pro_su f_ac_su f_h2_aa f_va_aa f_bu_aa f_pro_aa f_ac_aa...
 	   N_aa N_bac k_dis k_hyd_ch k_hyd_pr k_hyd_li...
 	   k_dec_Xsu k_dec_Xaa k_dec_Xfa k_dec_Xc4 k_dec_Xpro k_dec_Xac k_dec_Xh2...
 	   K_S_IN k_m_su K_S_su Y_su k_m_aa K_S_aa Y_aa k_m_fa K_S_fa Y_fa K_Ih2_fa...
 	   k_m_c4 K_S_c4 Y_c4 K_Ih2_c4 k_m_pro K_S_pro Y_pro K_Ih2_pro...
 	   k_m_ac K_S_ac Y_ac K_I_nh3 k_m_h2 K_S_h2 Y_h2...
 	   pH_UL_aa pH_LL_aa pH_UL_ac pH_LL_ac pH_UL_h2 pH_LL_h2...
 	   T_op V_liq V_gas K_w K_a_va K_a_bu K_a_pro K_a_ac K_a_co2 K_a_IN...
 	   k_A_Bva k_A_Bbu k_A_Bpro k_A_Bac k_A_Bco2 k_A_BIN R P_atm p_gas_h2o...
       K_H_co2 K_H_ch4 K_H_h2 kLa Cvsum1 Cvsum2 Cvsum3 Cvsum4 Cvsum5 Cvsum6...
       Cvsum7 Cvsum8 Cvsum9 Cvsum10 Cvsum11 Cvsum12 Cvsum13_19... 
	   C_su C_aa C_fa C_va C_bu C_pro C_ac C_ch4 C_sI C_xc C_ch C_pr C_li C_bac C_xI q_in...
       NO3_in NO2_in NO_in N2O_in N2_in Xnox_in...
       k_dec_Xnox k_no3_su k_no2_su k_no_su k_n2o_su k_no3_aa k_no2_aa k_no_aa k_n2o_aa k_no3_fa k_no2_fa k_no_fa k_n2o_fa...
       k_no3_va k_no2_va k_no_va k_n2o_va k_no3_bu k_no2_bu k_no_bu k_n2o_bu k_no3_pro k_no2_pro k_no_pro k_n2o_pro...
       k_no3_ac k_no2_ac k_no_ac k_n2o_ac k_no3_h2 k_no2_h2 k_no_h2 k_n2o_h2...
       K_S_su_no3 K_S_su_no2 K_S_su_no K_S_su_n2o K_S_aa_no3 K_S_aa_no2 K_S_aa_no K_S_aa_n2o K_S_fa_no3 K_S_fa_no2 K_S_fa_no K_S_fa_n2o...
       K_S_va_no3 K_S_va_no2 K_S_va_no K_S_va_n2o K_S_bu_no3 K_S_bu_no2 K_S_bu_no K_S_bu_n2o K_S_pro_no3 K_S_pro_no2 K_S_pro_no K_S_pro_n2o...
       K_S_ac_no3 K_S_ac_no2 K_S_ac_no K_S_ac_n2o K_S_h2_no3 K_S_h2_no2 K_S_h2_no K_S_h2_n2o K_S_no3 K_S_no2 K_S_no K_S_n2o...
       p_gas_no p_gas_n2o p_gas_n2 K_H_no K_H_n2o K_H_n2...
       Y_su_nox Y_aa_nox Y_fa_nox Y_va_nox Y_bu_nox Y_pro_nox Y_ac_nox Y_h2_nox...
       K_I_NO2 K_I_NO K_I_NO3 K_I_N2O Snox...
       X_nox Sno3 Sno2 Sno Sn2o Sn2 q_gas S_gas_no S_gas_n2o S_gas_n2 pH_UL_nox pH_LL_nox...
       f_no3_su f_no3_aa f_no3_fa f_no3_va f_no3_bu f_no3_pro f_no3_ac f_no3_h2...
       f_no2_su f_no2_aa f_no2_fa f_no2_va f_no2_bu f_no2_pro f_no2_ac f_no2_h2...
       f_no_su f_no_aa f_no_fa f_no_va f_no_bu f_no_pro f_no_ac f_no_h2...
       f_n2o_su f_n2o_aa f_n2o_fa f_n2o_va f_n2o_bu f_n2o_pro f_n2o_ac f_n2o_h2...
       c_no3_su c_no3_aa c_no3_fa c_no3_va c_no3_bu c_no3_pro c_no3_ac c_no3_h2...
       c_no2_su c_no2_aa c_no2_fa c_no2_va c_no2_bu c_no2_pro c_no2_ac c_no2_h2...
       c_no_su c_no_aa c_no_fa c_no_va c_no_bu c_no_pro c_no_ac c_no_h2...
       c_n2o_su c_n2o_aa c_n2o_fa c_n2o_va c_n2o_bu c_n2o_pro c_n2o_ac c_n2o_h2 S_co2...
       k_hyd_ch_feed k_hyd_pr_feed k_hyd_li_feed X_ch_feed X_pr_feed X_li_feed X_ch_feed_in X_pr_feed_in X_li_feed_in 
    
    % Initial Reactor Definition - Change initial variables for different reactor configuration.    
    % Assign Dynamic State Variables based on Anaerobic Digestion Model (ADM1)
    % ADM1 Page 8 - Table 2.6 (DAE System)
    % Legend:
    %   S_i denotes Soluble component i  (Units: kgCOD per m^3)
    %   X_i denotes Particulate component i  (Units: kgCOD per m^3)

    Ssu = 0; %0.011951;    % (1)  Monosaccharides
    Saa = 0; %0.0053459;   % (2)  Amino Acids
    Sfa = 0; %0.10246;     % (3)  Total Long Chain Fatty Acids (LCFA)
    Sva = 0; %0.010808;    % (4)  Total Valerate
    Sbu = 0; %0.014189;    % (5)  Total Butyrate
    Spro = 0; %0.016818;   % (6)  Total Propionate
    Sac = 0; %0.17852;     % (7)  Total Acetate
    Sh2 = 0; %2.4149e-7;   % (8)  Hydrogen
    Sch4 = 0; %0.048927;   % (9)  Methane
    SIC = 0; %0.094974;    % (10) Inorganic Carbon
    SIN = 0.22993;     % (11) Inorganic Nitrogen
    SI = 0; %5.5383;       % (12) Soluble Inerts
    Xxc = 0; %5.5083; % (13) Composite
    X_ch_feed = 4.98; %DEXTRIN
    Xch = 0; %0.055307;    % (14) Carbohydrates 
    X_pr_feed = 2.5;  %PEPTONE
    Xpr = 0; %0.055307;    % (15) Proteins
    X_li_feed = 0;
    Xli = 0;%0.082712;    % (16) Lipids
    Xsu = 0.3; %0.85547;     % (17) Biomass (Monosaccharides)
    Xaa = 0.242; %0.63749;     % (18) Biomass (Amino Acids)
    Xfa = 0.182; %0.67340;     % (19) Biomass (Long Chain Fatty Acids)
    Xc4 = 0.182; %0.28309;     % (20) Biomass (Valerate & Butyrate Combined)
    Xpro = 0.121; %0.13559;    % (21) Biomass (Propionate)
    Xac = 0.152; %0.90075;     % (22) Biomass (Acetate)
    Xh2 = 0.182; %0.43629;     % (23) Biomass (Hydrogen)
    XI = 0; %45.298;       % (24) Particulate Inerts
    Scat = 0; %0.039126;   % (25) Cations
    San = 0; %0.17846;     % (26) Anions
    Shva = 0; %0.010756;   % (27) 
    Shbu = 0; %0.014127;   % (28) 
    Shpro = 0; %0.016734;  % (29)  
    Shac = 0; %0.17784;    % (30)  
    Shco3 = 0; %0.083738;  % (31) 
    Snh3 = 0; %0.0037868;  % (32)
    S_H_ion = 1e-07;  % (33)

    % Reactor Operation Variables.
    S_gas_h2 = 0; %9.6439e-6;  % (34) 
    S_gas_ch4 = 0; %1.3647;    % (35) 
    S_gas_co2 = 0; %0.016042;  % (36) 
    X_nox =0.3*(Xc4+Xpro);
    %NOx reduction


    Sno3 = 0.05;
    Sno2 = 0;
    Sno = 0;
    Sn2o = 0;
    Sn2 = 0;
    Snox=Sno3+Sno2+Sno+Sn2o;

   if Snox>0
        X_nox =0.3*(Xc4+Xpro); %(37)
        Xc4 = 0.7*Xc4;
        Xpro = 0.7*Xpro;
    end
    S_gas_no = 0;
    S_gas_n2o = 0;
    S_gas_n2 = 0;
    
  
    % Assign Stochiometric Parameter Variables based on Anaerobic Digestion Model
    % (ADM1) Supplement (C. Rosen, U. Jeppsson)
    % Anaerobic Cost Benchmark Model Description, Version 1.2, November 5, 2002, pp. 9
    % Legend:
    %   C_i denotes Concentration of component i
    %   Y_i denotes Yield of component i
    %   f_i denotes Fraction of component i

    f_sI_xc = 0.1; % Soluble - Fractions of the decayed biomass upon disintegration. 
    f_xI_xc = 0.1; % Particulate
    f_ch_xc = 0.104; % Carbohydrates
    f_pr_xc = 0.664; % Proteins
    f_li_xc = 0.032;      %Lipids.... sum of all fractional components must equal '1'
    N_xc = 0.0376/14;   % maintain N mass balance
    N_I = 0.06/14;      % N in inerts in BSM1=6% on COD basis
    N_aa = 0.007;       % N content in amino acids and part protein
    C_xc = 0.03;
    C_sI = 0.03;
    C_ch = 0.0313;
    C_pr = 0.03;
    C_li = 0.022;
    C_xI = 0.03;
    C_su = 0.0313;
    C_aa = 0.03;
    f_fa_li = 0.95;
    C_fa = 0.0217;
    f_h2_su = 0.19;
    f_bu_su = 0.13;
    f_pro_su = 0.27;
    f_ac_su = 0.41;
    N_bac = 0.08/14;    % N in biomass in BSM1=8% on COD basis
    C_bu = 0.025;
    C_pro = 0.0268;
    C_ac = 0.0313;
    C_bac = 0.0313;
    Y_su = 0.1;
    f_h2_aa = 0.06;
    f_va_aa = 0.23;
    f_bu_aa = 0.26;
    f_pro_aa = 0.05;
    f_ac_aa = 0.40;
    C_va = 0.024;
    Y_aa = 0.08;
    Y_fa = 0.06;
    Y_c4 = 0.06;
    Y_pro = 0.04;
    C_ch4 = 0.0156;
    Y_ac = 0.05;
    Y_h2 = 0.06;

    % Assign Biochemical Parameter Variables based on Anaerobic Digestion Model
    % (ADM1) Supplement (C. Rosen, U. Jeppsson)
    % Anaerobic Cost Benchmark Model Description, Version 1.2, November 5, 2002, pp. 10
    % Legend:
    %   k_i denotes kinetic rate coefficient of component i

    k_dis = 2;   % Modified
    k_hyd_ch = 0.15; % Modified
    k_hyd_pr = 0.5; % Modified
    k_hyd_li = 0.15; % Modified
    k_hyd_ch_feed = 2; % Modified
    k_hyd_pr_feed = 2; % Modified
    k_hyd_li_feed = 2; % Modified
    K_S_IN = 1e-4; 
    k_m_su = 30;
    K_S_su = 0.5;
    pH_UL_aa = 5.5;
    pH_LL_aa = 4;
    k_m_aa = 50;
    K_S_aa = 0.3;
    k_m_fa = 6;
    K_S_fa = 0.4;
    K_Ih2_fa = 5e-6;
    k_m_c4 = 20;
    K_S_c4 = 0.2;
    K_Ih2_c4 = 1e-5;
    k_m_pro = 5.6; % Modified
    K_S_pro = 0.5;  % Modified using the model calibration. Increased from 100 to 500 mg subs-COD/L
    K_Ih2_pro = 3.5e-6;
    k_m_ac = 6;  % Modified
    K_S_ac = 0.15;
    K_I_nh3 = 0.0018;
    pH_UL_ac = 7;
    pH_LL_ac = 6;
    k_m_h2 = 35;
    K_S_h2 = 7e-6;
    pH_UL_h2 = 6;
    pH_LL_h2 = 5;
    k_dec_Xsu = 0.03;  % The value was 0.02 d-1 in the original ADM1 Model
    k_dec_Xaa = 0.03;
    k_dec_Xfa = 0.03;
    k_dec_Xc4 = 0.03;
    k_dec_Xpro = 0.03;
    k_dec_Xac = 0.03;
    k_dec_Xh2 = 0.03;

    % Assign Physiochemical Parameter Variables based on Anaerobic Digestion
    % Model (ADM1) Supplement (C. Rosen, U. Jeppsson)
    % Anaerobic Cost Benchmark Model Description, Version 1.2, November 5, 2002, pp. 11

    R = 0.08314;            % [bar m3/kmol K]
    T_base = 273.15;        % Degrees Kelvin
    T_op = T_base + 35;     % Mesophilic Reactor (35 degrees C)
    K_w = 2.08e-14;
    K_a_va = 1.38e-5;
    K_a_bu = 1.51e-5;
    K_a_pro = 1.32e-5;
    K_a_ac = 1.74e-5;
    K_a_co2 = 4.94e-7;
    K_a_IN = 1.11e-9;
    k_A_Bva = 1e8;
    k_A_Bbu = 1e8;
    k_A_Bpro = 1e8;
    k_A_Bac = 1e8;
    k_A_Bco2 = 1e8;
    k_A_BIN = 1e8;
    P_atm = 1.013;
    p_gas_h2o = 0.0557;
    kLa = 200;
    K_H_co2 = 0.0271;
    K_H_ch4 = 0.00116;
    K_H_h2 = 7.38e-4;
    
    q_in = 5.3e-5; %,5.2e-5;       % Default Flow Rate Design Parameter (m3/day)
    V_liq = 0.00185;%0.0018;    % Default Liquid Volume (m3)
    V_gas = 0.00045;     % Default Gas Volume (m3)
    tres_x = 0;    % Default Solids Retention Time (d) - equivalent to SRT
    DEBUG = 0;       % Default DEBUG mode OFF (FALSE)
 
    % Acid-base reactions
    deltaH0_Ka_w = 55900;
    deltaH0_Ka_co2 = 7646;
    deltaH0_Ka_nh4 = 51965;
    K_w = 2.08e-14;     %10^(-14)*exp(deltaH0_Ka_w/(R*100)*(1/298.15-1/Top)) 		
    K_a_va = 1.38e-5;   %10^(-4.86)
    K_a_bu = 1.51e-5;   %10^(-4.82)
    K_a_pro = 1.32e-5;  %10^(-4.88)
    K_a_ac = 1.74e-5;   %10^(-4.76)
    K_a_co2 = 4.94e-7;  %10^(-6.35)*exp(deltaH0_Ka_co2/(R*100)*(1/298.15-1/Top))		
    K_a_IN = 1.11e-9;   %10^(-9.25)*exp(deltaH0_Ka_nh4/(R*100)*(1/298.15-1/Top))		

    % Gas transfer
    P_atm = 1.013; 
    p_gas_h2o = 0.0557; %0.0313*exp(5290*(1/298.15-1/Top)); 	
    deltaH0_KH_co2 = -19410;
    deltaH0_KH_ch4 = -14240;
    deltaH0_KH_h2 = -4180;
    K_H_co2 =  0.0271;  %0.035*exp(deltaH0_KH_co2/(R*100)*(1/298.15-1/Top))		
    K_H_ch4 = 0.00116;  %0.0014*exp(deltaH0_KH_ch4/(R*100)*(1/298.15-1/Top))	
    K_H_h2 = 7.38e-4;   %7.8e-4*exp(deltaH0_KH_h2/(R*100)*(1/298.15-1/Top))		
    kLa =200; 								

    % Precalculation of yields for state 10 (S_IC)
    C_su = 0.0313; 
    C_aa = 0.03;        % according to Aquasim
    C_fa = 0.0217; 
    C_va = 0.024;
    C_bu = 0.025;
    C_pro = 0.0268;
    C_ac = 0.0313;
    C_ch4 = 0.0156;
    C_sI = 0.03;
    C_xc = 0.03;
    C_ch = 0.0313;
    C_pr = 0.03;
    C_li = 0.022;
    C_bac = 0.0313;
    C_xI = 0.03;
    
    % NOx reduction parameters
    % for sugar uptake
    k_dec_Xnox = 0.5;
    k_no3_su = 0;%13.91; %20.86;
    k_no2_su = 0;%1.82;%9.08; %18.15;
    k_no_su = 0;%31.24;
    k_n2o_su = 0;%33.8;
    K_S_su_no3 = 0.2;
    K_S_su_no2 = 0.2;
    K_S_su_no = 0.2;
    K_S_su_n2o = 0.2;
    
    %for aminoacid uptake
    k_no3_aa = 0;%13.15; %19.72;
    k_no2_aa = 0;%1.74;%8.69; %17.37;
    k_no_aa = 0;%30.13;
    k_n2o_aa = 0;%32.46;
    K_S_aa_no3 = 0.1;
    K_S_aa_no2 = 0.1;
    K_S_aa_no = 0.1;
    K_S_aa_n2o = 0.1;
    
    %for LCFA uptake
    k_no3_fa =0;%8.12; %12.18;
    k_no2_fa = 0;%1.12;%5.58; %11.16;
    k_no_fa = 0;%18.44;
    k_n2o_fa =0;% 20.08;
    K_S_fa_no3 = 0.1;
    K_S_fa_no2 = 0.1;
    K_S_fa_no = 0.1;
    K_S_fa_n2o = 0.1;
    
    %for valerate uptake
    k_no3_va = 3;%2;%8.28; %12.42; % Calculated by stoichiometry and adjusted according to the experimental data.
    k_no2_va = 1.45; %1.595;%1.45;%1.13;%5.66; %11.32; changed accord. to continuous was 1.595
    k_no_va = 18.74;
    k_n2o_va = 20.46;
    K_S_va_no3 = 0.1; %0.01;
    K_S_va_no2 = 0.1; %0.01;
    K_S_va_no = 0.1; %0.01;
    K_S_va_n2o = 0.1; %0.01;
    
    %for butyrate uptake
    k_no3_bu = 3;%2;%8.28; %12.42;
    k_no2_bu = 1.45;%1.13;%5.66; %11.32;
    k_no_bu = 18.74;
    k_n2o_bu = 20.46;
    K_S_bu_no3 = 0.1; %0.01;
    K_S_bu_no2 = 0.1; %0.01;
    K_S_bu_no = 0.1; %0.01;
    K_S_bu_n2o = 0.1; %0.01;
    
    %for propionate uptake
    k_no3_pro = 0.27; %3, %2;%8.23; %12.34;  % The value was adjusted according to the results of Kinetics experiments done by Tugtas and Pavlostathis (2007)
    k_no2_pro = 1.45;%1.13;%5.66; %11.32;
    k_no_pro = 18.74;
    k_n2o_pro = 20.46;
    K_S_pro_no3 = 0.5; %0.01;
    K_S_pro_no2 = 0.5; %0.01; %0.25;
    K_S_pro_no = 0.25;
    K_S_pro_n2o = 0.25;
    
    %for acetate uptake
    k_no3_ac = 1.34; %3--;%2;%8.17; %12.26; % The value was adjusted according to the results of Kinetics experiments done by Tugtas and Pavlostathis (2007)
    k_no2_ac = 1.45;%1.12;%5.61; %11.21;
    k_no_ac = 18.44;
    k_n2o_ac = 20.08;
    K_S_ac_no3 = 0.5; %0.0058; %0.25;0.25;
    K_S_ac_no2 = 0.5; %0.0058; %0.25;0.25;
    K_S_ac_no = 0.25; %0.0058; %0.25;
    K_S_ac_n2o = 0.25; %0.0058; %0.25;
    
    %for hydrogen uptake
    k_no3_h2 = 1.35;%0.21--0.138;%0.346;%6.93; % The value was adjusted according to the results of Kinetics experiments done by Tugtas and Pavlostathis (2007)
    k_no2_h2 = 0.18;%0.136;%0.17;%6.8;
    k_no_h2 = 8.05;
    k_n2o_h2 =8.33;
    K_S_h2_no3 = 0.0000016;
    K_S_h2_no2 = 0.0000016;
    K_S_h2_no = 0.0000016;
    K_S_h2_n2o = 0.0000016;
    
    % for NOx 
    K_S_no3 = 0.0042 ;%0.078(Literature); %Taken from the experimental data (see data for propionate Utilization). Paper Tugtas(2007) BB 98(4): 756-763
    K_S_no2 = 0.01;
    K_S_no = 0.028; %0.056; % Stated differently in the WST paper, however this value is used in the model.
    K_S_n2o = 0.056; %0.028; %0.0615;%0.056; changed according to the value in the continuous model was 0.0615
    
    %Yields for X_nox
    Y_su_nox = 0.4;
    Y_aa_nox = 0.39;
    Y_fa_nox = 0.32;
    Y_va_nox = 0.32;
    Y_bu_nox = 0.32;
    Y_pro_nox = 0.32;
    Y_ac_nox = 0.32;
    Y_h2_nox = 0.12;
    
    %gas Transfer constants
    K_H_no = 1.82e-3;
    K_H_n2o = 2.46e-2;
    K_H_n2 = 6.31e-4;
    
    % NOx inhibition
    K_I_NO3 = 0.042;%;0.2;
    K_I_NO2 = 0.0007;%0.014;
    K_I_N2O = 0.00182;
    K_I_NO = 0.00003; %0.00016; 
    pH_UL_nox = 5;
    pH_LL_nox = 11;
    
    % Kinetic parameter switching constants for NOx reduction
    f_no3_su = 0.24;
    f_no3_aa = 0.25;
    f_no3_fa = 0.4;
    f_no3_va = 0.4;
    f_no3_bu = 0.4;
    f_no3_pro = 0.4;
    f_no3_ac = 0.4;
    f_no3_h2 = 0.71;
    
    f_no2_su = 0.54;
    f_no2_aa = 0.57;
    f_no2_fa = 0.88;
    f_no2_va = 0.87;
    f_no2_bu = 0.87;
    f_no2_pro = 0.87;
    f_no2_ac = 0.88;
    f_no2_h2 = 1.45;
    
    f_no_su = 0.31;
    f_no_aa = 0.33;
    f_no_fa = 0.54;
    f_no_va = 0.53;
    f_no_bu = 0.53;
    f_no_pro = 0.53;
    f_no_ac = 0.53;
    f_no_h2 = 1.23;
    
    f_n2o_su = 0.29;
    f_n2o_aa = 0.3;
    f_n2o_fa = 0.49;
    f_n2o_va = 0.48;
    f_n2o_bu = 0.48;
    f_n2o_pro = 0.49;
    f_n2o_ac = 0.49;
    f_n2o_h2 = 1.19;
    
    % Kinetic parameter switching constants for NOx reduction
    c_no3_su = 1.31e-2;
    c_no3_aa = 2.92e-3;
    c_no3_fa = 6.92e-3;
    c_no3_va = 5.58e-3;
    c_no3_bu = 5.12e-3;
    c_no3_pro = 4.3e-3;
    c_no3_ac = 2.2e-3;
    c_no3_h2 = 4.38e-3;
    
    c_no2_su = 1.4e-2;
    c_no2_aa = 3.96e-3;
    c_no2_fa = 7.98e-3;
    c_no2_va = 6.63e-3;
    c_no2_bu = 6.2e-3;
    c_no2_pro = 5.3e-3;
    c_no2_ac = 3.13e-3;
    c_no2_h2 = 4.38e-3;
    
    c_no_su = 1.07e-2;
    c_no_aa = 6.25e-4;
    c_no_fa = 3.03e-3;
    c_no_va = 1.73e-3;
    c_no_bu = 1.25e-3;
    c_no_pro = 4.48e-4;
    c_no_ac = 1.72e-3;
    c_no_h2 = 7.5e-3;
    
    c_n2o_su = 1.04e-2;
    c_n2o_aa = 2.08e-4;
    c_n2o_fa = 2.42e-3;
    c_n2o_va = 1.15e-3;
    c_n2o_bu = 6.87e-4;
    c_n2o_pro = 1.8e-4;
    c_n2o_ac = 2.35e-3;
    c_n2o_h2 = 8.13e-3;
    % Finish Anaerobic Digester Initialization 