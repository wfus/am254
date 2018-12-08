count = 0;
for i = 1:1000
    count = count + cs_simulate_l1(100, 0.9, 0.5);
end
count / 1000