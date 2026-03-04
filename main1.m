clear all
close all

G = 6.67384e-11;              % Gravitational constant
Me = 5.972e+24;               % Earth Mass
Oe = 7.2921151467e-5;         % Earth rotation angular velocity (rad/s) 
tol = 1.e-8;                  % tolerance for convergence 

global fd;
fd = fopen("main1.dat", "w");

plotworld();

esec = gpstime(26, 02, 2026, 12, 00, 00);
% esec = gpstime(DD, MM, YYYY, hh, mm, ss);
% esec = gpstime();

% ******** Week 359 almanac for PRN-09 ********
% ID:                         09
% Health:                     000
% Eccentricity:               0.3363132477E-002
% Time of Applicability(s):   405504.0000
% Orbital Inclination(rad):   0.9646486122
% Rate of Right Ascen(r/s):  -0.7817468486E-008
% SQRT(A)  (m 1/2):           5153.735352
% Right Ascen at Week(rad):  -0.1029058803E+001
% Argument of Perigee(rad):   2.065742194
% Mean Anom(rad):             0.2087359114E+001
% Af0(s):                     0.7686614990E-003
% Af1(s/s):                   0.0000000000E+000
% week:                       359

id = 9;                       % sat. identifier 
e = 0.3363132477E-002;        % orbit eccentricity
toa = 405504;                 % Time of Applicability [seconds within current week] 
io = 0.9646486122;            % orbit inclination [rad] 
dO = -0.7817468486E-008;      % derivative of right ascension of AN [rad/s] 
a = 5153.735352^2;            % orbit semi-major axis [m] 
Lo = -0.1029058803E+001;      % longitude of AN at week epoch [rad] (uncorrected) 
w = 2.065742194;              % argument of perigee [rad] 
Mo = 0.2087359114E+001;       % Mean Anomaly at ToA [rad] 

% ===== STEP 1 ====

t_target = 388818;

dt = t_target - toa;

Oo = Lo - Oe*toa;

fprintf(fd, "Oo = %f, esec = %f, dt = %f\n\n", mod(Oo, 2 * pi), esec, dt); 

% ===== STEP 7 ====

% M = mean_anomaly(G, Me, a, Mo, dt)
% E = eccentric(e, tol, M)
% v = true_anomaly(e, E)
% [xp, yp] = orbitcoords(v, w, a, e, E)
% ecef = satecef(Oe, Oo, dO, dt, io, xp, yp)
% lla = ecef2lla(ecef);
% long = lla(1)  % Longitude from LLA
% lat = lla(2)   % Latitude from LLA

[lat, long] = subsatellite(Oe, G, Me, a, Mo, dt, e, tol, w, Oo, dO, io);

hold on;
plot(long, lat, 'r*') 
text(long + 2, lat + 1, sprintf('%d', id)); 

% ===== STEP 9 ==== 

mu = G*Me;                 % parametro gravitatorio
T  = 2*pi*sqrt(a^3/mu);    % periodo orbital (s) ~ 43082 para GPS
step_min = 5;              % 5 min = 300 s
step = step_min*60;

% Para groundtrack "completo" (patrón repetible): 2 órbitas ~ 1 día sideral
N = ceil((2*T)/step);      % ~289

vec = zeros(N, 2);

t0 = t_target;

for k = 1:N

    t = t0 + (k-1)*step;   % actual GPS time
    dt = t - toa;          % time since almanac epoch

    [lat, long] = subsatellite(Oe, G, Me, a, Mo, dt, e, tol, w, Oo, dO, io);

    % Asegura longitudes en [-180, 180] por si esta fuera del rango
    long = mod(long + 180, 360) - 180;

    vec(k, 1) = long;
    vec(k, 2) = lat;
end

plot(vec(:, 1), vec(:, 2), 'b.');

fclose(fd);
