net_arq = [2 7 7 1];
batch = 1;
format long
%err=0.001; err2=0.01; g=@tanh_ft; g_der=@tanh_ft_der; betha=0.5; n=0.002; alpha=0.9; a=0.002; b=0.1; K = 5; random = 0; p = 0.8;
err=0.001; lr=0.01; betha=0.5; n=0.002; alpha=0.9; a=0.002; b=0.1; K = 5; random = 0; p = 0.8;
smart_initialization = 0; minlim=-0.5; maxlim=0.5;
max_seasons = 500000;

tanh_f = 1;

% All the terrain
terr=load("../../data/terrain5-sorted.txt");
[M terr_n] = normalize_terrain(tanh_f,terr);
te{1} = terr_n(:,1:2);
te{2} = terr_n(:,3);
% Training set
terr1=load("../../data/training_sets/skippingrows.txt");
terr_n1 = normalize_sampling(tanh_f,M,terr1);
t{1} = terr_n1(:,1:2);
t{2} = terr_n1(:,3);
% Testing set
terr2=load("../../data/testing_sets/skippingrows.txt");
terr_n2 = normalize_sampling(tanh_f,M,terr2);
t2{1} = terr_n2(:,1:2);
t2{2} = terr_n2(:,3);
