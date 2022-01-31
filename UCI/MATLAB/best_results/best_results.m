function [x, y] = best_results(path, title_name)

    T =  readtable(strcat(path));

    A = table2array(T);
    A_size = size(A);

    accuracy = sortrows(A(:, 1:2));
    loss = sortrows(A(:, 3:4));
    val_accuracy = sortrows(A(:, 5:6));
    val_loss = sortrows(A(:, 7:8));

    figure('name', title_name, 'NumberTitle','off')
    title(title_name)
    subplot(2, 2, 1)
    stairs(accuracy(:, 1), accuracy(:, 2), 'r');
    title('Accuracy')
    grid on
    ylabel('Accuracy')


    subplot(2, 2, 2)
    stairs(loss(:, 1), loss(:, 2), 'r');
    title('Loss')
    grid on
    ylabel('loss')


    subplot(2, 2, 3)
    stairs(val_accuracy(:, 1), val_accuracy(:, 2), 'r');
    title('Val Accuracy')
    grid on
    xlabel('Nodes No')
    ylabel('Accuracy')


    subplot(2, 2, 4)
    stairs(val_loss(:, 1), val_loss(:, 2), 'r');
    title('Val Loss')
    grid on
    xlabel('Nodes No')
    ylabel('loss')
    
    saveas(gcf,strcat(title_name, '.jpg'))
end