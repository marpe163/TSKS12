data=-1*[4;4;-4;-4;-4;-4;-4;-4;-4;-4]
[alpha,beta]=alpha_beta_gen(data)
rec=[];
for it=1:5
    rec=[rec mapbitest(alpha,beta,it,data)]
end