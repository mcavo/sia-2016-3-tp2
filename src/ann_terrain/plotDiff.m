o = feedfoward(net, t{1}, g, betha);
O = o{size(net)(2)}
terr_out = denormalize_terrain(1,O,M);
figure(3)
hold on
plot3(terr(:,1),terr(:,2),terr(:,3),'r.')
plot3(terr(:,1),terr(:,2),terr_out,'g.')
hold off

figure (4)
plot(1:length(terr_out),(terr(:,3)-terr_out).^2,'p');