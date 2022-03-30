clear 
clc
close all

%% Change amp to achieve different inputs. amp = [0.1, 0.2, 0.3]
amp = 0.3;

%% defining parameters with sysms
x = sym('x', [2,1]);
x_dot = sym('x_dot', [2, 1]);
syms u;

x_equ = [0.2; 0];
u_equ = 0.16;

x_dot(1) = x(2);
x_dot(2) = -x(1) - x(2) + u/(1-x(1));

%% Taking jacobian and subbing it. 
A = jacobian(x_dot, x);
B = jacobian(x_dot, u);
eig(A)

A = double(subs(A, [x; u], [x_equ; u_equ]));
B = double(subs(B, [x; u], [x_equ; u_equ]));

%% Computing the output for Second order system
mdl = 'non_linear_system_2.slx';
open_system(mdl)
sim(mdl);