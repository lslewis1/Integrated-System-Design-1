
function f = y_axis_up()
    set_param('Final_system/sm1_pulse', 'Period',  num2str(1/150));
    set_param('Final_system/sm1_pulse', 'Amplitude',  num2str(1));
    set_param('Final_system/sm1_rotate', 'Value',  num2str(1));
    
    set_param('Final_system/sm2_pulse', 'Period',  num2str(1/150));
    set_param('Final_system/sm2_pulse', 'Amplitude',  num2str(1));
    set_param('Final_system/sm2_rotate', 'Value',  num2str(0));
end
