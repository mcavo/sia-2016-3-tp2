o1 = feedfoward(net, t{1}, g, betha);
O1 = o1{size(net)(2)};
terr_out1 = denormalize_terrain(1,O1,M(3,:));
o2 = feedfoward(net, t2{1}, g, betha);
O2 = o2{size(net)(2)};
terr_out2 = denormalize_terrain(1,O2,M(3,:));

figure(5)
hold on
plot3(terr(:,1),terr(:,2),terr(:,3),'r.')
legend('Terrain');
plot3(terr1(:,1),terr1(:,2),terr_out1,'g.','DisplayName','Training set');
title('Terrain representation - Training set', 'fontsize', 20, 'fontname', 'avenir next');
xlabel('x1', 'fontsize', 15, 'fontname', 'avenir next');
ylabel('x2', 'fontsize', 15, 'fontname', 'avenir next');
zlabel('z', 'fontsize', 15, 'fontname', 'avenir next');
hold off

figure(6)
hold on
plot3(terr(:,1),terr(:,2),terr(:,3),'r.')
legend('Terrain');
plot3(terr2(:,1),terr2(:,2),terr_out2,'g.','DisplayName','Testing set');
title('Terrain representation - Testing set', 'fontsize', 20, 'fontname', 'avenir next');
xlabel('x1', 'fontsize', 15, 'fontname', 'avenir next');
ylabel('x2', 'fontsize', 15, 'fontname', 'avenir next');
zlabel('z', 'fontsize', 15, 'fontname', 'avenir next');
hold off
