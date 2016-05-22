o1 = feedfoward(net, t{1}, g, betha);
O1 = o1{size(net)(2)}
terr_out1 = denormalize_terrain(1,O1,M(3,:));
o2 = feedfoward(net, t2{1}, g, betha);
O2 = o2{size(net)(2)}
terr_out2 = denormalize_terrain(1,O2,M(3,:));

figure(5)
hold on
plot3(terr(:,1),terr(:,2),terr(:,3),'r.')
legend('Terrain');
plot3(terr(:,1),terr(:,2),terr_out1,'g.','DisplayName','Training set');
plot3(terr(:,1),terr(:,2),terr_out2,'b.','DisplayName','Testing set');
hold off

figure (6)
plot(1:length(terr_out),(terr(:,3)-terr_out).^2,'p');