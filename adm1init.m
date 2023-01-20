% ADM1 variables initialization sets parameter values for the ADM1
% CSTR according to recommended values of Batstone, Rosen, Jeppsson, et. al.
% SOLID STATE Modification for LBR

function ret=adm1init()

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
    K_S_su pH_UL_aa pH_LL_aa  k_m_aa  K_S_aa k_m_fa  K_S_fa  K_Ih2_fa k_m_c4 K_S_c4 K_Ih2_c4  k_m_pro... 
    K_S_pro K_Ih2_pro k_m_ac K_S_ac K_I_nh3 pH_UL_ac  pH_LL_ac k_m_h2  K_S_h2 pH_UL_h2 pH_LL_h2... 
    k_dec_Xsu k_dec_Xaa k_dec_Xfa k_dec_Xc4 k_dec_Xpro k_dec_Xac k_dec_Xh2...
    R T_base T_op K_w K_a_va K_a_bu K_a_pro K_a_ac K_a_co2 K_a_IN k_A_Bva k_A_Bbu k_A_Bpro k_A_Bac... 
    k_A_Bco2 k_A_BIN kLa K_H_co2 K_H_ch4 K_H_h2... 
    q_in V_liq  V_gas tres_x   ... 
    P_atm p_gas_h2o  kp q_gas K_I_vfa  K_I_vfach4 ...
    f_fa_ac f_but_ac f_val_ac ...
    f_pro_ac f_fa_h2 f_but_h2 f_val_h2 f_pro_h2...
    delG_glutoAA delG_glutoBA delG_glutoPA delG_FAtoAA delG_FAtoH2 delG_VAtoPA delG_VAtoAA...
    delG_VAtoH2  delG_BAtoAA delG_BAtoH2 delG_PAtoAA  delG_PAtoH2 delG_H2toAce R_inh...
    MW_glu COD_glu COD_fa MW_fa MW_va COD_va MW_bu COD_bu MW_pro COD_pro...
    MW_ace COD_ace MW_H2 COD_H2...
    k_m_homo K_S_homo k_dec_Xhomo Y_homo Xhomo f_val_pro ...
    k_m_ce K_S_CE k_dec_Xce XCE Slac  f_h2_lac  ...
    Sca f_ca_lac ...
    bool1 bool2 ...
    % Initial Reactor Definition - Change initial variables for different reactor configuration.    
    % Assign Dynamic State Variables based on Anaerobic Digestion Model (ADM1)
    % ADM1 Page 8 - Table 2.6 (DAE System)
    % Legend:
    %   S_i denotes Soluble component i  (Units: kgCOD per m^3)
    %   X_i denotes Particulate component i  (Units: kgCOD per m^3)
   
    Ssu = 0.01;    % (1)  Monosaccharides
    Saa = 0.001;    % (2)  Amino Acids
    Sfa = 0.001;     % (3)  Total Long Chain Fatty Acids (LCFA)
    Slac=0.001;
    Sca=0.42;
    Sva = 0.001; %0.001;     % (4)  Total Valerate
    Sbu = 0.1485;%0.001;     % (5)  Total Butyrate
    Spro = 0.1147;%0.001;    % (6)  Total Propionate
    Sac = 0.8191;%0.001;      % (7)  Total Acetate
    Sh2 = 1e-8;    % (8)  Hydrogen
    Sch4 = 1e-8;    % (9)  Methane

    SIC = 0.094974;    % (10) Inorganic Carbon
    SIN = 0.01;     % (11) Inorganic Nitrogen

    % json buraya kadar
    q_gas=0;
    SI = 0.0001; %5.5383;       % (12) Soluble Inerts
    Xxc = 30;%67.5; %5.5083; % (13) Composite
    Xch = 23.1;%2;     % (14) Carbohydrates 
    Xpr = 2.2;%20;     % (15) Proteins
    Xli = 1.1;%2.1;%1.9;% 5;  % (16) Lipids
    Xsu = 0.001;     % (17) Biomass (Monosaccharides)
    Xaa = 0.001;     % (18) Biomass (Amino Acids)
    Xfa = 0.001;     % (19) Biomass (Long Chain Fatty Acids)
    Xc4 = 0.001;     % (20) Biomass (Valerate & Butyrate Combined)
    Xpro = 0.001;    % (21) Biomass (Propionate)
    Xac = 0; %0.90075;     % (22) Biomass (Acetate)
    Xh2 = 0; %0.43629;     % (23) Biomass (Hydrogen)
    Xhomo=0.001; %Biomass (homoacetogens)
    XCE=0.001; % Biomass chain elongation
    XI =25.1;%5.6;%6.4; %45.298;       % (24) Particulate Inerts
    Scat = 0.04;   % (25) Cations
    San = 0.02;     % (26) Anions
    Shva = 0;   % (27) 
    Shbu = 0;   % (28) 
    Shpro = 0;  % (29)  
    Shac = 0;    % (30)  
    Shco3 = 0;  % (31) 
    Snh3 = 0;  % (32)
    S_H_ion = 1e-07;  % (33)
    
    % Reactor Operation Variables.
    S_gas_h2 = 10e-8;  % (34) 
    S_gas_ch4 = 10e-8;    % (35) 
    S_gas_co2 = 10e-8;  % (36) 
    kp=50000; % m3/d-bar needs to be readjusted to achieve a reasonable overpressure in the head space
 
    % Assign Stochiometric Parameter Variables based on Anaerobic Digestion Model
    % (ADM1) Supplement (C. Rosen, U. Jeppsson)
    % Anaerobic Cost Benchmark Model Description, Version 1.2, November 5, 2002, pp. 9
    % Legend:
    %   C_i denotes Concentration of component i
    %   Y_i denotes Yield of component i
    %   f_i denotes Fraction of component i

    f_sI_xc = 0.05; % Soluble - Fractions of the decayed biomass upon disintegration. 
    f_xI_xc = 0.05; % Particulate
    f_ch_xc = 0.77; % Carbohydrates
    f_pr_xc = 0.1; % Proteins
    f_li_xc = 0.03;      %Lipids.... sum of all fractional components must be equal to '1'
    N_xc = 0.0376/14;   % maintain N mass balance
    N_I = 0.06/14;      % N in inerts in BSM1=6% on COD basis
    N_aa = 0.007;       % N content in amino acids and part protein
    C_xc = 0.002786;
    C_sI = 0.03;
    C_ch = 0.0313;
    C_pr = 0.03;
    C_li = 0.022;
    C_xI = 0.03;
    C_su = 0.0313;
    C_aa = 0.03;
    f_fa_li = 0.95; %ADM1
    C_fa = 0.0217;
    %f_su_h2 = 0.09;
    %f_su_bu = 0.23;%0.41;%0.13;
    %f_su_pro = 0.06;%0.27;
   % f_su_ac = 0.41;%0.13;%0.41;
    %f_su_lac = 0.21;%CHAIN ELONGATION
    f_fa_ac = 0.7;%ADM1
    f_fa_h2=0.3;%ADM1
    f_but_ac = 0.8;%0.9; %ADM1
    f_but_h2=0.2;%0.1;%ADM1
    f_val_ac=0.31;%0.8;%ADM1
    f_val_pro=0.54;%0.15;%ADM1
    f_val_h2=0.15;%0.05;%ADM1
    f_pro_ac=0.57; %ADM1
    f_pro_h2=0.43;%ADM1
    f_ca_lac=0.89; %CHAIN ELONGATION
    %f_but_lac = 0.86; %CHAIN ELONGATION
    f_h2_lac = 0.11; %CHAIN ELONGATION
    %fac_lac=0.19;%CHAIN ELONGATION
    
    N_bac = 0.08/14;    % N in biomass in BSM1=8% on COD basis
    C_bu = 0.025;
    C_pro = 0.0268;
    C_ac = 0.0313;
    C_bac = 0.0313;
    Y_su = 0.1;
    f_h2_aa = 0.06;%ADM1
    f_va_aa = 0.23;%0.05;%ADM1
    f_bu_aa = 0.26;%0.28%ADM1
    f_pro_aa = 0.05;%ADM1
    f_ac_aa = 0.4;%0.56%ADM1

    C_va = 0.024;
    Y_aa = 0.08;
    Y_fa = 0.06;
    Y_c4 = 0.06;
    Y_pro = 0.04;
    C_ch4 = 0.0156;
    Y_ac = 0;%0.05;
    Y_h2 = 0;%0.06;
    Y_homo=0.115; % yield coeff of homoacetogens 
    Y_ce=0.13;%CHAIN ELONGATION

    % Assign Biochemical Parameter Variables based on Anaerobic Digestion Model
    % (ADM1) Supplement (C. Rosen, U. Jeppsson)
    % Anaerobic Cost Benchmark Model Description, Version 1.2, November 5, 2002, pp. 10
    % Legend:
    %   k_i denotes kinetic rate coefficient of component i

    k_dis = 0.5;   % Modified
    k_hyd_ch = 0.1;%0.3; % Modified (Carbohydrate hydrolysis rate constant)
    k_hyd_pr =0.1;%0.2; % Modified (Protein hydrolysis rate constant)
    k_hyd_li = 0.1;%0.1; % Modified (Lipid hydrolysis rate constant)
   % k_hyd_ch_feed = 0.15; % Modified
   % k_hyd_pr_feed = 0.5; % Modified
   %  k_hyd_li_feed = 0.15; % Modified
    K_S_IN = 1e-4; 
    k_m_su = 10;%30;
    K_S_su = 0.1;%0.5;
    pH_UL_aa = 5.5;
    pH_LL_aa = 4;
    k_m_aa = 50;
    K_S_aa = 0.3;
    k_m_fa = 8;
    K_S_fa = 0.4;
    K_Ih2_fa = 5e-6;
    k_m_c4 = 20;%6;
    K_S_c4 = 0.2;%0.5;
    K_Ih2_c4 = 1e-3;
    k_m_pro = 13; % Modified
    K_S_pro = 0.1;  % Modified using the model calibration. Increased from 100 to 500 mg subs-COD/L
    K_Ih2_pro = 3.5e-6;
    k_m_ac = 8;  % Modified
    K_S_ac = 0.15;
    K_I_nh3 = 0.0018;
    K_I_vfa=5;  %Fezzani and Cheikh, CEJ, 2008, Implementation of IWA ADM1...
    K_I_vfach4=15;
    pH_UL_ac = 7;
    pH_LL_ac = 5;
    k_m_h2 = 35;
    K_S_h2 = 7e-6;
    pH_UL_h2 = 6;
    pH_LL_h2 = 5.5;
    k_m_ce=10; %0.03-0.62  ref:Nascimento BITE reports 2022
    K_S_CE=0.3; %0.82-4.15
    
    k_m_homo=60; % Homoacetogens kg COD/kgCOD.d
    K_S_homo=5.5e-6; % Homoacetogens kg COD/m3
    
    k_dec_Xsu = 0.01;  % The value was 0.02 d-1 in the original ADM1 Model
    k_dec_Xaa = 0.01;
    k_dec_Xfa = 0.01;
    k_dec_Xc4 = 0.01;
    k_dec_Xpro = 0.01;
    k_dec_Xac = 0;
    k_dec_Xh2 = 0;
    k_dec_Xhomo=0.01;
    k_dec_Xce=0.001;
    
    
    
    delG_glutoAA=-215.67; % kJ/mol Palmitic acid is taken as a representative
    delG_glutoPA=-357.9; % kJ/mol 
    delG_glutoBA=-261.46; % kJ/mol 
    delG_FAtoAA=-404.8; % kJ/mol palmitate
    delG_FAtoH2=-404.8; % kJ/mol 
    delG_VAtoPA=48.4; % kJ/mol 
    delG_VAtoAA=48.4; % kJ/mol 
    delG_VAtoH2=48.2; % kJ/mol 
    delG_BAtoAA=48.1; % kJ/mol 
    delG_BAtoH2=48.1; % kJ/mol
    delG_PAtoAA=76.1; % kJ/mol 
    delG_PAtoH2=76.1; % kJ/mol
    delG_H2toAce=-94.9; %kJ/mol
    R_inh=8.314;% m3Pa/Kmol
    
    MW_glu=180;% 
    COD_glu=1.06;% 
    
    COD_fa=2.87;% COD eq of palmitate
    MW_fa=256.42;%  palmitate
    MW_va=102;% 
    COD_va=2.04;
    MW_bu=88;%
    COD_bu=1.82;
    MW_pro=74;% 
    COD_pro=1.514;% 
    MW_ace=60;% 
    COD_ace=1.06;% 
    MW_H2=2;% 
    COD_H2=8;% 
    
    % Assign Physiochemical Parameter Variables based on Anaerobic Digestion
    % Model (ADM1) Supplement (C. Rosen, U. Jeppsson)
    % Anaerobic Cost Benchmark Model Description, Version 1.2, November 5, 2002, pp. 11

    R = 0.083145;            % [bar m3/kmol K]
    T_base = 273.15;        % Degrees Kelvin
    T_op = 308.15;     % Mesophilic Reactor (35 degrees C)
    K_w = 2.08e-14;
    K_a_va = 1.38e-5;
    K_a_bu = 1.5e-5;
    K_a_pro = 1.32e-5;
    K_a_ac = 1.74e-5;
    K_a_co2 = 4.94e-7;
    K_a_IN = 1.11e-9;
    k_A_Bva = 1e10;
    k_A_Bbu = 1e10;
    k_A_Bpro = 1e10;
    k_A_Bac = 1e10;
    k_A_Bco2 = 1e10;
    k_A_BIN = 1e10;
    kLa = 200;
    K_H_co2 = 0.0271;
    K_H_ch4 = 0.00116;
    K_H_h2 = 7.38e-4;
    
    q_in = 0; %5.2e-5;       % Default Flow Rate Design Parameter (m3/day)
    V_liq = 0.00125;%0.0018;    % Default Liquid Volume (m3)
    V_gas = 0.005;     % Default Gas Volume (m3)
    tres_x = 75;    % Default Solids Retention Time (d) - equivalent to SRT

    % Gas transfer
    P_atm = 1.013; 
    p_gas_h2o = 0.0557; %0.0313*exp(5290*(1/298.15-1/Top)); 	
    p_gas_ch4 = 0;
   %deltaH0_KH_co2 = -19410;
   % deltaH0_KH_ch4 = -14240;
   % deltaH0_KH_h2 = -4180;
    K_H_co2 =  0.0271;  %0.035*exp(deltaH0_KH_co2/(R*100)*(1/298.15-1/Top))		
    K_H_ch4 = 0.00116;  %0.0014*exp(deltaH0_KH_ch4/(R*100)*(1/298.15-1/Top))	
    K_H_h2 = 7.38e-4;   %7.8e-4*exp(deltaH0_KH_h2/(R*100)*(1/298.15-1/Top))		
							

    time=0:0.2:70;

    [t,dX]=ode15s('adm1sys', time, [Ssu Saa Sfa Sva Sbu Spro Sac Sh2 Sch4 SIC SIN SI Xxc Xch Xpr Xli Xsu Xaa Xfa Xc4 Xpro Xac Xh2 XI Scat San Shva Shbu Shpro...
        Shac Shco3 Snh3 S_H_ion S_gas_h2 S_gas_ch4 S_gas_co2 q_gas Xhomo XCE Slac Sca]);
    ret = dX