function raw_generate_data(time)

    %% Generates test and training data for nn of 512 samples (1 or 0.5 second
    %  depends on fs) as inputs in every column and 513 is an expected value 
    %  1 or 0. In the rescale part, InputMax should be set to the 
    %  maximum value of the test and training data in order to rescale
    %  them to 0->1. If test data has 1000 as the biggest value and
    %  training data 1500, then InputMax both for train and test data should
    %  be 1500. Train data is one hour of iEEG signals, test another one
    %  for example for patient 02 train 230,  test 233 time.

    %time='233'; % hours
    patient='02';
    electrodes_num = 1;%numel(EEG(:,1));

    exp_name =strcat('ID', patient, '_', time, 'h');

    load(strcat('../../data/ID', patient, '/', exp_name, '.mat'));
    load(strcat('../../data/ID', patient, '/ID', patient, '_info.mat'));

    fs=double(fs);

    y = EEG(1, :);            % get the first channel
    N = length(y);                           % signal length
    t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

    % seizure_begin_* and end_* are vectors with all seizures for the patient
    seizure_begin_h = ceil(seizure_begin/3600);
    seizure_begin_s = ceil(mod(seizure_begin, 3600));
    seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
    seizure_end_h = ceil(seizure_end/3600);
    seizure_end_s = ceil(mod(seizure_end, 3600));
    seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));

    y_desired = zeros(1, N/fs);

    for i=1:numel(seizure_begin_s)
        y_desired(seizure_begin_s(i):seizure_end_s(i))=1;    
    end

    dir_name = strcat('data', time);    
    mkdir(dir_name);

    factor=1;

    for electrode=1:electrodes_num
        index=1;
        dataset = zeros(N/fs*factor, fs);
        for i=1: fs/factor: N-fs/factor+1 % move every quarter of the second
            %y_mean(index) = mean(y(electrode_number, i: i+fs/factor-1).^2);
            y = EEG(electrode, :);     
            dataset(index,:) = y(i: i+fs-1); % half of the second samples
            %dataset_y(index) = y_desired(i);
            index=index+1;
        end
        file_name = strcat('data_', int2str(electrode), '.csv');
        writematrix([rescale(dataset, 'InputMax', 1500), y_desired'], file_name)
        movefile(file_name, dir_name);
    end
    %% check if y_desired is in the good place
    t1 = (0:N-1)/fs;                         % time vector

    figure(3)
    plot(t1, y, 'r');
    xlim([0 max(t1)])
    ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
    grid on
    xlabel('Time, s')
    ylabel('Amplitude, mV')
    title('Signal');
    hold on
    stairs((1:3600),y_desired*1000, 'b');
    hold off
end