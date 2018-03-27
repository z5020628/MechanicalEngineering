# MechanicalEngineering
area = pi*(0.001^2);
E = 2.47*(10^9);
L = 0.125;
nodenum = 9;
memnum = 15;
pointnode = 3;
pointforce = -10;
deg = 2;
support = deg*5;

deltax = 0.125;
deltay = 0.10825;

horizx = deltax/L;
horizy = 0/L;

forwx = (deltax/2)/L;
forwy = deltay/L;

backx = -(deltax/2)/L;
backy = deltay/L;

%bottom members
a = [area, E,L, horizx, horizy, 1,2];
b = [area, E,L, horizx, horizy, 2,3];
c = [area, E,L, horizx, horizy, 3,4];
d = [area, E,L, horizx, horizy, 4,5];

%top members
r = [area, E,L, -horizx, horizy, 8,9];
s = [area, E,L, -horizx, horizy, 7,8];
t = [area, E,L, -horizx, horizy, 6,7];

%backward slanting members
f = [area, E,L, backx, backy, 5,6];
h = [area, E,L, backx, backy, 4,7];
m = [area, E,L, backx, backy, 3,8];
o = [area, E,L, backx, backy, 2,9];

%forward slanting members
q = [area, E,L, forwx, forwy, 1,9];
n = [area, E,L, forwx, forwy, 2,8];
k = [area, E,L, forwx, forwy, 3,7];
g = [area, E,L, forwx, forwy, 4,6];

%matrix with all the truss information
infomat = [a;b;c;d;f;g;h;k;m;n;o;q;r;s;t];
%preallocating the global stifness matrix
glob = zeros(nodenum*deg);

%loop creating global stiffness matrix
for z = 1:memnum

  stiff = stiffness(infomat(z,:) , nodenum*deg) ;
  glob = glob+stiff;

end

%Making Kcon
reaction = eye(deg*nodenum, deg);
con = glob ;
con(:,1:deg) = reaction;
con(1:deg, deg+1:end) = zeros(deg, (deg*nodenum -deg));
con(:,support) = zeros(deg*nodenum,1);
con(support,:) = zeros(1, deg*nodenum);
con(support,support) = 1;

%making Pcon
Pcon = zeros(deg*nodenum,1);
Pcon(deg*pointnode) = pointforce;

%finding node displacements
u = con\Pcon;

%finding reaction forces
P = glob*u;

%preallocating then calculating the axial forces in members 
Force = zeros(memnum,1);

for z = 1:memnum

   Force(z) = internalforce(infomat(z,:), u) ;

end


Stress = Force/area;
comparison = [Force, Stress];
