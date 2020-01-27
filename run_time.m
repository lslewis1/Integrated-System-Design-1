function f = run_time(n,y)
    t = timer('TimerFcn', 'stat=false; stop()',... 
                     'StartDelay',n);
    start(t)
  
    if y==1            
        x_axis_right();            
    elseif y==2
        y_axis_down();
    elseif y==3
        x_axis_left();
    elseif y==4
        y_axis_up();

    end
    
   
    
end
