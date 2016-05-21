o = feedfoward(net, t{1}, g, betha);
O = o{size(net)(2)}
terr_out = denormalize_terrain(1,O,M(3,:));
figure(3)
hold on
plot3(terr_n(:,1),terr_n(:,2),terr_n(:,3),'r.')
plot3(terr_n(:,1),terr_n(:,2),O,'g.')
hold off

figure (4)
plot(1:length(terr_out),(terr_n(:,3)-O).^2,'p');









figure(5)
hold on
plot3(terr(:,1),terr(:,2),terr(:,3),'r.')
plot3(terr(:,1),terr(:,2),terr_out,'g.')
hold off

figure (6)
plot(1:length(terr_out),(terr(:,3)-terr_out).^2,'p');