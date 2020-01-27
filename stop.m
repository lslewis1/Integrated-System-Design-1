
function f = stop()
    set_param('Final_system/sm1_pulse', 'Period',  num2str(1/50));
    set_param('Final_system/sm2_pulse', 'Period',  num2str(1/50));
    set_param('Final_system/sm1_pulse', 'Amplitude',  num2str(0));
    set_param('Final_system/sm2_pulse', 'Amplitude',  num2str(0));
end
