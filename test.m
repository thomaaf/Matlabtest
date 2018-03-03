    
motor_eff_table = single(100*reshape([0.6437000036239624,0.5799999833106995,0.44999998807907104,0.3499999940395355,0.28999999165534973,0.23999999463558197,0.20000000298023224,0.17000000178813934,0.14000000059604645,0.12999999523162842,0.10999999940395355,0.7099999785423279,0.699999988079071,0.6100000143051148,0.5099999904632568,0.4399999976158142,0.3799999952316284,0.33000001311302185,0.28999999165534973,0.25,0.2199999988079071,0.20000000298023224,0.7300000190734863,0.7699999809265137,0.7300000190734863,0.6700000166893005,0.6100000143051148,0.550000011920929,0.5,0.44999998807907104,0.4000000059604645,0.36000001430511475,0.33000001311302185,0.7400000095367432,0.800000011920929,0.7900000214576721,0.7400000095367432,0.6899999976158142,0.6399999856948853,0.5899999737739563,0.5400000214576721,0.5,0.46000000834465027,0.41999998688697815,0.75,0.8199999928474426,0.8199999928474426,0.7799999713897705,0.7400000095367432,0.699999988079071,0.6600000262260437,0.6100000143051148,0.5699999928474426,0.5299999713897705,0.49000000953674316,0.7599999904632568,0.8399999737739563,0.8500000238418579,0.8299999833106995,0.800000011920929,0.7699999809265137,0.7400000095367432,0.699999988079071,0.6600000262260437,0.6200000047683716,0.5899999737739563,0.7699999809265137,0.8500000238418579,0.8799999952316284,0.8700000047683716,0.8600000143051148,0.8399999737739563,0.8100000023841858,0.7799999713897705,0.7599999904632568,0.7200000286102295,0.699999988079071,0.7699999809265137,0.8500000238418579,0.8899999856948853,0.8799999952316284,0.8700000047683716,0.8500000238418579,0.8299999833106995,0.8100000023841858,0.7799999713897705,0.7599999904632568,0.7300000190734863,0.7699999809265137,0.8600000143051148,0.8999999761581421,0.8999999761581421,0.8899999856948853,0.8700000047683716,0.8500000238418579,0.8299999833106995,0.8100000023841858,0.7900000214576721,0.6700000166893005,0.7799999713897705,0.8600000143051148,0.8999999761581421,0.9100000262260437,0.8999999761581421,0.8899999856948853,0.8700000047683716,0.8600000143051148,0.8299999833106995,0.7699999809265137,0.699999988079071],11,10));
eff_rpm_break = single([500,1000,2000,3000,4000,6000,10000,12000,15000,21000]);
eff_torque_break = single([1.3,2.7,5.4,7.9,10.4,12.5,14.4,16.0,17.4,18.5,19.6]);
x_0 = single([5,4,8,12]');
rpm = single([1500, 3000, 2000, 1000]);
figure
[x,y] = Plotter(5,1500);
plot(x,y);
hold on;
[x,y] = Plotter(4,3000);
paijsdp;

epsilon = 0.1;
%rpm = [single(max(500,states.RPM_FL)),single(max(500,states.RPM_FR)),single(max(500,states.RPM_RL)),single(max(500,states.RPM_RR))];
eta_slope = zeros(1,size(x_0,1))'
for i = 1:size(x_0,1)
    threepoint =  x_0(i)-epsilon:epsilon:x_0(i)+epsilon;
    rpm_i = single(rpm(i)*ones(1,size(threepoint,2 )));
    eta = interp2(eff_rpm_break,eff_torque_break,motor_eff_table, rpm_i,threepoint)/100;
    delta_x = threepoint(end)- threepoint(1);
    delta_eta = eta(end) - eta(1);
    slope = delta_eta / delta_x;
    eta_slope(i) = slope;
    plot ( eff_torque_break,slope*eff_torque_break +abs(slope*x_0(i)) + eta(2))

end
legend ('x_1','x_2','x_3','x_4','x_1 lin','x_2 lin','x_3 lin','x_4 lin')
eta_slope

%     Algorithm for single motor at singe query    
%        threepoint = x_0-0.1:0.1:x_0+0.1;
%         rpm = single(states.*ones(size(threepoint )));
%         eta = interp2(eff_rpm_break,eff_torque_break,motor_eff_table, rpm,threepoint)/100;
% 
%         delta_x = threepoint(end)- threepoint(1);
%         delta_eta = eta(end) - eta(1);
%         slope = delta_eta / delta_x;%   abs(slope*x_0);
%         eta(2);
