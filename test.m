function test(h,D)
for x=-10:0.1:10
   if x>D
       y=h;
       hold on;
       plot(x,y)
   elseif x<-D
       y=-h;  
       hold on;
       plot(x,y)
   else
       y=h/(D*x);
       hold on;
       plot(x,y)
   end
end

% ���룺deploytool������matlab com builder