classdef github < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MortgageCalculatorUIFigure     matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        MonthlyPaymentEditField        matlab.ui.control.NumericEditField
        Cargarmegger                   matlab.ui.control.Button
        LoanPeriodYearsEditField       matlab.ui.control.NumericEditField
        LoanPeriodYearsEditFieldLabel  matlab.ui.control.Label
        InterestRateEditField          matlab.ui.control.NumericEditField
        InterestRateEditFieldLabel     matlab.ui.control.Label
        LoanAmountEditField            matlab.ui.control.NumericEditField
        LoanAmountEditFieldLabel       matlab.ui.control.Label
        RightPanel                     matlab.ui.container.Panel
        PrincipalInterestUIAxes        matlab.ui.control.UIAxes
        data3                          double   % Aquí se agrega la 
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

%     Callbacks that handle component events
methods (Access = private)
        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.MortgageCalculatorUIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {316, 316};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {257, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
end

%         Button pushed function: MonthlyPaymentButton
%         function MonthlyPaymentButtonPushed(~, event)
                       
%             Calculate the monthly payment
%             amount = app.LoanAmountEditField.Value;
%             rate = app.InterestRateEditField.Value/12/100;
%             nper = 12*app.LoanPeriodYearsEditField.Value;
%             payment = (amount*rate)/(1-(1+rate)^-nper);
%             app.MonthlyPaymentEditField.Value = payment;
%             
%             pre allocating and initializing variables
%             interest = zeros(1,nper);
%             principal = zeros(1,nper);
%             balance = zeros (1,nper);
%             
%             balance(1) = amount;

%  function MonthlyPaymentButtonPushed(app, event)
%                        
%             % Calculate the monthly payment
%             amount = app.LoanAmountEditField.Value;
%             rate = app.InterestRateEditField.Value/12/100;
%             nper = 12*app.LoanPeriodYearsEditField.Value;
%             payment = (amount*rate)/(1-(1+rate)^-nper);
%             app.MonthlyPaymentEditField.Value = payment;
%             
%             % pre allocating and initializing variables
%             interest = zeros(1,nper);
%             principal = zeros(1,nper);
%             balance = zeros (1,nper);
%             
%             balance(1) = amount;

%            Callbacks that handle component events
        methods (Access = private)
            
function cargarmeggerButtonPushed(app, ~)
    % Crear el botón numérico
    app.Cargarmegger = uibutton(app.LeftPanel, 'push');
    
    % Abrir el diálogo de selección de archivo
    [nombreArchivo, rutaArchivo] = uigetfile('*.csv', 'Selecciona un archivo de Excel');
    
    % Verificar si se seleccionó un archivo
    if isequal(nombreArchivo, 0)
        disp('No se seleccionó ningún archivo.');
        return;
    end
    
    % Construir la ruta completa del archivo seleccionado
    archivoExcel = fullfile(rutaArchivo, nombreArchivo);
    
    % Ahora puedes utilizar el archivoExcel en tu código
    disp(['Archivo seleccionado: ' archivoExcel]);
    
    % Resto del código que deseas ejecutar con el archivo seleccionado
end

        end



%             Calculate the principal and interest over time
%             for i = 1:nper
%                 interest(i)  = balance(i)*rate;
%                 principal(i) = payment - interest(i);
%                 balance(i+1) = balance(i) - principal(i);
%             end
%             
%             Plot the principal and interest
%             plot(app.PrincipalInterestUIAxes,(1:nper)',principal, ...
%                 (1:nper)',interest);
%             legend(app.PrincipalInterestUIAxes,{'Principal','Interest'},'Location','Best')
%             xlim(app.PrincipalInterestUIAxes,[0 nper]); 
%             ylim(app.PrincipalInterestUIAxes,'auto');
%             
%         end
%     end

% ====================FUNCON DE PLOTEO DESDE DATA
% =====================================
 methods (Access = private)
function plotGraph(app)
    % Crear una figura y establecer sus propiedades
   set(gcf, 'Units', 'inches', 'Position', [1 1 8 4])
%carga
grid on

loglog(data3(:,1),data3(:,2),'red','LineWidth',2)
hold on
loglog(data3(:,1),data3(:,3),'blue','LineWidth',2)
% loglog(ma(5:1020,1),ma(5:1020,20),'k','LineWidth',2)

xlim([1, 1020]); % Rango del eje x entre 1 y 1020
ylim([6e-12,5e-4]); % Rango del eje y entre 5e-4 y 5e-8

ax = gca;
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';
ax.XAxis.Color = 'k';
ax.YAxis.Color = 'k';
ax.FontSize = 12;

legend('carga','descarga');
title('current (Amps)/time (s) U2023');
xlabel('time (s)');
ylabel('current (Amps)');
exportgraphics(gcf, 'figura1.png', 'Resolution', 300)
hold off
end
 end

% ==================


    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create MortgageCalculatorUIFigure and hide until all components are created
            app.MortgageCalculatorUIFigure = uifigure('Visible', 'off');
            app.MortgageCalculatorUIFigure.AutoResizeChildren = 'off';
            app.MortgageCalculatorUIFigure.Position = [500 500 653 316];
            app.MortgageCalculatorUIFigure.Name = 'PDC';
            app.MortgageCalculatorUIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.MortgageCalculatorUIFigure);
            app.GridLayout.ColumnWidth = {257, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;
            app.LeftPanel.Scrollable = 'on';

            % Create LoanAmountEditFieldLabel
            app.LoanAmountEditFieldLabel = uilabel(app.LeftPanel);
            app.LoanAmountEditFieldLabel.HorizontalAlignment = 'right';
            app.LoanAmountEditFieldLabel.Position = [50 230 77 22];
            app.LoanAmountEditFieldLabel.Text = '1';

            % Create LoanAmountEditField
            app.LoanAmountEditField = uieditfield(app.LeftPanel, 'numeric');
            app.LoanAmountEditField.Limits = [0 1000000000];
            app.LoanAmountEditField.ValueDisplayFormat = '%8.f';
            app.LoanAmountEditField.Position = [142 230 100 22];
            app.LoanAmountEditField.Value = 300000;

            % Create InterestRateEditFieldLabel
            app.InterestRateEditFieldLabel = uilabel(app.LeftPanel);
            app.InterestRateEditFieldLabel.HorizontalAlignment = 'right';
            app.InterestRateEditFieldLabel.Position = [39 177 88 22];
            app.InterestRateEditFieldLabel.Text = '2';

            % Create InterestRateEditField
            app.InterestRateEditField = uieditfield(app.LeftPanel, 'numeric');
            app.InterestRateEditField.Limits = [0.001 100];
            app.InterestRateEditField.Position = [142 177 100 22];
            app.InterestRateEditField.Value = 4;

            % Create LoanPeriodYearsEditFieldLabel
            app.LoanPeriodYearsEditFieldLabel = uilabel(app.LeftPanel);
            app.LoanPeriodYearsEditFieldLabel.HorizontalAlignment = 'right';
            app.LoanPeriodYearsEditFieldLabel.Position = [15 124 112 22];
            app.LoanPeriodYearsEditFieldLabel.Text = '3';

            % Create LoanPeriodYearsEditField
            app.LoanPeriodYearsEditField = uieditfield(app.LeftPanel, 'numeric');
            app.LoanPeriodYearsEditField.Limits = [10 40];
            app.LoanPeriodYearsEditField.ValueDisplayFormat = '%.0f';
            app.LoanPeriodYearsEditField.Position = [142 124 100 22];
            app.LoanPeriodYearsEditField.Value = 30;

            % Create MonthlyPaymentButton
            app.Cargarmegger = uibutton(app.LeftPanel, 'push');
            app.Cargarmegger.ButtonPushedFcn = createCallbackFcn(app, @cargarmeggerButtonPushed, true);
            app.Cargarmegger.Position = [19 71 108 22];
            app.Cargarmegger.Text = 'Load ';

            % Create MonthlyPaymentEditField
            app.MonthlyPaymentEditField = uieditfield(app.LeftPanel, 'numeric');
            app.MonthlyPaymentEditField.ValueDisplayFormat = '%7.2f';
            app.MonthlyPaymentEditField.Editable = 'off';
            app.MonthlyPaymentEditField.Position = [142 71 100 22];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;
            app.RightPanel.Scrollable = 'on';

            % Create PrincipalInterestUIAxes
            app.PrincipalInterestUIAxes = uiaxes(app.RightPanel);
            title(app.PrincipalInterestUIAxes, 'PDCU')
            xlabel(app.PrincipalInterestUIAxes, 'Time (Months)')
            ylabel(app.PrincipalInterestUIAxes, 'Amount')
            app.PrincipalInterestUIAxes.Position = [30 36 600 400];

               % Create PrincipalInterestUIAxes
            app.PrincipalInterestUIAxes = uiaxes(app.RightPanel);
            title(app.PrincipalInterestUIAxes, 'PDCV')
            xlabel(app.PrincipalInterestUIAxes, 'Time (Months)')
            ylabel(app.PrincipalInterestUIAxes, 'Amount')
          app.PrincipalInterestUIAxes.Position = [650 36 600 400];


               % Create PrincipalInterestUIAxes
            app.PrincipalInterestUIAxes = uiaxes(app.RightPanel);
            title(app.PrincipalInterestUIAxes, 'PDCW')
            xlabel(app.PrincipalInterestUIAxes, 'Time (Months)')
            ylabel(app.PrincipalInterestUIAxes, 'Amount')
            app.PrincipalInterestUIAxes.Position = [30 520 600 400];


                  % Create PrincipalInterestUIAxes
            app.PrincipalInterestUIAxes = uiaxes(app.RightPanel);
            title(app.PrincipalInterestUIAxes, 'PDCAUW')
            xlabel(app.PrincipalInterestUIAxes, 'Time (Months)')
            ylabel(app.PrincipalInterestUIAxes, 'Amount')
            app.PrincipalInterestUIAxes.Position = [650 520 600 400];


            % Show the figure after all components are created
            app.MortgageCalculatorUIFigure.Visible = 'on';
        end
    end

%     App creation and deletion
    methods (Access = public)

%         Construct app
        function app = github

%             Create UIFigure and components
            createComponents(app)

%             Register the app with App Designer
            registerApp(app, app.MortgageCalculatorUIFigure)

            if nargout == 0
                clear app
            end
        end

%         Code that executes before app deletion
        function delete(app)

%             Delete UIFigure when app is deleted
            delete(app.pdca2)
        end
    end
end