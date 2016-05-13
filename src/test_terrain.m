terr = load("../data/terrain5.txt")
x = terr(:,1)';
y = terr(:,2)';
z = terr(:,3)';
plot3(x,y,z,'.')