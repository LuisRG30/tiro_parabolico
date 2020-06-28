classdef tiro < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        ResistenciaEditFieldLabel       matlab.ui.control.Label
        ResistenciaEditField            matlab.ui.control.NumericEditField
        V0msEditFieldLabel              matlab.ui.control.Label
        V0msEditField                   matlab.ui.control.NumericEditField
        AnguloEditFieldLabel            matlab.ui.control.Label
        AnguloEditField                 matlab.ui.control.NumericEditField
        UIAxes                          matlab.ui.control.UIAxes
        EmpezarButton                   matlab.ui.control.Button
        VelocidadinstantaneamsTextAreaLabel  matlab.ui.control.Label
        VelocidadinstantaneamsTextArea  matlab.ui.control.TextArea
        PosicionenxTextAreaLabel        matlab.ui.control.Label
        PosicionenxTextArea             matlab.ui.control.TextArea
        PosicionenxTextAreaLabel_2      matlab.ui.control.Label
        PosicionenxTextArea_2           matlab.ui.control.TextArea
        Aceleracionms2TextAreaLabel     matlab.ui.control.Label
        Aceleracionms2TextArea          matlab.ui.control.TextArea
        MaxyalturaTextAreaLabel         matlab.ui.control.Label
        MaxyalturaTextArea              matlab.ui.control.TextArea
        MaxxdistanciaTextAreaLabel      matlab.ui.control.Label
        MaxxdistanciaTextArea           matlab.ui.control.TextArea
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
        end

        % Value changed function: ResistenciaEditField
        function ResistenciaEditFieldValueChanged(app, event)
            value = app.ResistenciaEditField.Value;
            
        end

        % Value changed function: V0msEditField
        function V0msEditFieldValueChanged(app, event)
            value = app.V0msEditField.Value;
            
        end

        % Value changed function: AnguloEditField
        function AnguloEditFieldValueChanged(app, event)
            value = app.AnguloEditField.Value;
            
        end

        % Button pushed function: EmpezarButton
        function EmpezarButtonPushed(app, event)
            res=app.ResistenciaEditField.Value
            v0_i=app.V0msEditField.Value
            angulo=app.AnguloEditField.Value
            a=1
            color=["r","b","g","k","y"]
            k= randi(5)
            curve=animatedline('Color',color(1,k));
            counter=0
             for i=1:a
   
    
    
    
end
            
           
            
    altura = 5450;
    t = 0:0.2:60;
    v0_x = (v0_i)*cosd(angulo); 
    v0_y = (v0_i)*sind(angulo);
    x= v0_x*t;
    y = altura + (v0_y*t) + (((0.5*-9.8)*(x.^2))/(v0_x.^2)) - (res*(x.^2))/(v0_x.^2); 
    
    set(gca,'XLim',[0 15000],'YLim',[0 7000]);
    grid on 
    
    y_ant = altura;
    for i=1:length(x)
        addpoints(curve,x(i),y(i));
        drawnow
        xlabel("distancia")
        ylabel("altura")
        plot(app.UIAxes,x,y)
        v_y = v0_y + (x(i)/v0_x)*(-9.8-res);
        v = ((v_y.^2) + (v0_x.^2)).^0.5;
        acc = -9.8 - (2*(res*(v_y)));
        if y(i) < 0
                maxx = x(i);
                break
        end
        if y(i)>0
            app.PosicionenxTextArea.Value=["x= ",num2str(x(i))]
            
            app.PosicionenxTextArea_2.Value=["y= ",num2str(y(i))]
            while y_ant < y(i)
                y_ant = y(i);
            end
            app.Aceleracionms2TextArea.Value=num2str(acc)
            app.VelocidadinstantaneamsTextArea.Value=num2str(v)
            
        end
        
    end
    maxy = y_ant;
    val=app.MaxyalturaTextArea.Value
    val2=app.MaxxdistanciaTextArea.Value
    app.MaxyalturaTextArea.Value=[val;num2str(maxy)]
    app.MaxxdistanciaTextArea.Value=[val2;num2str(maxx)]
    
        end

        % Value changed function: PosicionenxTextArea
        function PosicionenxTextAreaValueChanged(app, event)
            value = app.PosicionenxTextArea.Value;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 764 468];
            app.UIFigure.Name = 'UI Figure';

            % Create ResistenciaEditFieldLabel
            app.ResistenciaEditFieldLabel = uilabel(app.UIFigure);
            app.ResistenciaEditFieldLabel.HorizontalAlignment = 'right';
            app.ResistenciaEditFieldLabel.Position = [19 258 67 22];
            app.ResistenciaEditFieldLabel.Text = 'Resistencia';

            % Create ResistenciaEditField
            app.ResistenciaEditField = uieditfield(app.UIFigure, 'numeric');
            app.ResistenciaEditField.ValueChangedFcn = createCallbackFcn(app, @ResistenciaEditFieldValueChanged, true);
            app.ResistenciaEditField.Position = [101 258 100 22];

            % Create V0msEditFieldLabel
            app.V0msEditFieldLabel = uilabel(app.UIFigure);
            app.V0msEditFieldLabel.HorizontalAlignment = 'right';
            app.V0msEditFieldLabel.Position = [203 258 46 22];
            app.V0msEditFieldLabel.Text = 'V0. m/s';

            % Create V0msEditField
            app.V0msEditField = uieditfield(app.UIFigure, 'numeric');
            app.V0msEditField.ValueChangedFcn = createCallbackFcn(app, @V0msEditFieldValueChanged, true);
            app.V0msEditField.Position = [264 258 100 22];

            % Create AnguloEditFieldLabel
            app.AnguloEditFieldLabel = uilabel(app.UIFigure);
            app.AnguloEditFieldLabel.HorizontalAlignment = 'right';
            app.AnguloEditFieldLabel.Position = [207 224 43 22];
            app.AnguloEditFieldLabel.Text = 'Angulo';

            % Create AnguloEditField
            app.AnguloEditField = uieditfield(app.UIFigure, 'numeric');
            app.AnguloEditField.ValueChangedFcn = createCallbackFcn(app, @AnguloEditFieldValueChanged, true);
            app.AnguloEditField.Position = [265 224 100 22];

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Lanzamiento del proyectil')
            xlabel(app.UIAxes, 'Distancia')
            ylabel(app.UIAxes, 'Altura')
            app.UIAxes.YLim = [0 7000];
            app.UIAxes.Position = [363 12 367 446];

            % Create EmpezarButton
            app.EmpezarButton = uibutton(app.UIFigure, 'push');
            app.EmpezarButton.ButtonPushedFcn = createCallbackFcn(app, @EmpezarButtonPushed, true);
            app.EmpezarButton.BackgroundColor = [0 1 0];
            app.EmpezarButton.Position = [23 12 100 22];
            app.EmpezarButton.Text = 'Empezar';

            % Create VelocidadinstantaneamsTextAreaLabel
            app.VelocidadinstantaneamsTextAreaLabel = uilabel(app.UIFigure);
            app.VelocidadinstantaneamsTextAreaLabel.HorizontalAlignment = 'right';
            app.VelocidadinstantaneamsTextAreaLabel.Position = [19 434 157 22];
            app.VelocidadinstantaneamsTextAreaLabel.Text = 'Velocidad instantanea. m/s';

            % Create VelocidadinstantaneamsTextArea
            app.VelocidadinstantaneamsTextArea = uitextarea(app.UIFigure);
            app.VelocidadinstantaneamsTextArea.Position = [183 431 109 27];

            % Create PosicionenxTextAreaLabel
            app.PosicionenxTextAreaLabel = uilabel(app.UIFigure);
            app.PosicionenxTextAreaLabel.HorizontalAlignment = 'right';
            app.PosicionenxTextAreaLabel.Position = [19 344 77 22];
            app.PosicionenxTextAreaLabel.Text = 'Posicion en x';

            % Create PosicionenxTextArea
            app.PosicionenxTextArea = uitextarea(app.UIFigure);
            app.PosicionenxTextArea.ValueChangedFcn = createCallbackFcn(app, @PosicionenxTextAreaValueChanged, true);
            app.PosicionenxTextArea.Position = [35 291 110 54];
            app.PosicionenxTextArea.Value = {''; ''};

            % Create PosicionenxTextAreaLabel_2
            app.PosicionenxTextAreaLabel_2 = uilabel(app.UIFigure);
            app.PosicionenxTextAreaLabel_2.HorizontalAlignment = 'right';
            app.PosicionenxTextAreaLabel_2.Position = [167 344 77 22];
            app.PosicionenxTextAreaLabel_2.Text = 'Posicion en y';

            % Create PosicionenxTextArea_2
            app.PosicionenxTextArea_2 = uitextarea(app.UIFigure);
            app.PosicionenxTextArea_2.Position = [198 291 110 54];
            app.PosicionenxTextArea_2.Value = {''; ''};

            % Create Aceleracionms2TextAreaLabel
            app.Aceleracionms2TextAreaLabel = uilabel(app.UIFigure);
            app.Aceleracionms2TextAreaLabel.HorizontalAlignment = 'right';
            app.Aceleracionms2TextAreaLabel.Position = [65 395 103 22];
            app.Aceleracionms2TextAreaLabel.Text = 'Aceleracion m/s^2';

            % Create Aceleracionms2TextArea
            app.Aceleracionms2TextArea = uitextarea(app.UIFigure);
            app.Aceleracionms2TextArea.Position = [174 393 109 27];

            % Create MaxyalturaTextAreaLabel
            app.MaxyalturaTextAreaLabel = uilabel(app.UIFigure);
            app.MaxyalturaTextAreaLabel.HorizontalAlignment = 'right';
            app.MaxyalturaTextAreaLabel.Position = [189 194 75 22];
            app.MaxyalturaTextAreaLabel.Text = 'Max y(altura)';

            % Create MaxyalturaTextArea
            app.MaxyalturaTextArea = uitextarea(app.UIFigure);
            app.MaxyalturaTextArea.Position = [189 43 127 152];

            % Create MaxxdistanciaTextAreaLabel
            app.MaxxdistanciaTextAreaLabel = uilabel(app.UIFigure);
            app.MaxxdistanciaTextAreaLabel.HorizontalAlignment = 'right';
            app.MaxxdistanciaTextAreaLabel.Position = [34 194 93 22];
            app.MaxxdistanciaTextAreaLabel.Text = 'Max x(distancia)';

            % Create MaxxdistanciaTextArea
            app.MaxxdistanciaTextArea = uitextarea(app.UIFigure);
            app.MaxxdistanciaTextArea.Position = [34 43 127 152];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Reto_final_RodrigoP_LuisR_JoaH_AndreaV_DanielaZ_DanielB_PabloO

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end