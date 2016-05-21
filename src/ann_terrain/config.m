terr=load("../../data/terrain5-all.txt");
[M terr_n] = normalize_terrain(1,terr);
t{1} = terr_n(:,1:2);
t{2} = terr_n(:,3);
nett = initialize_mutilayer_network([2 7 1],-0.5,0.5);
err=0.001; g=@tanh_ft; g_der=@tanh_ft_der; betha=0.5; n=0.02; alpha=0.9; a=0.005; b=0.1;
K = 5; random = 0; p = 0.8;
