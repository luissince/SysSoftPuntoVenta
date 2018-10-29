package controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.AnchorPane;
import model.DetalleADO;
import model.DetalleTB;

public class FxDetalleProcesoController implements Initializable {

    @FXML
    private AnchorPane window;
    @FXML
    private TextField txtDetalle;

    private int idDetalle;

    private String idMantenimiento;

    private FxDetalleListaController listaController;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        Tools.DisposeWindow(window, KeyEvent.KEY_RELEASED);
        idDetalle = 0;
        idMantenimiento = "";
    }

    private void toValidateRegister() {
        if (idMantenimiento.equalsIgnoreCase("")) {
            Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Detalle", "Problemas en obtener el id, cierre la ventana y abra de otra ves", false);
        } else if (Tools.isText(txtDetalle.getText())) {
            Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Detalle", "Ingrese el nombre del detalle", false);
        } else {
            short confirmation = Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.CONFIRMATION, "Mantenimiento", "¿Esta seguro de continuar?", true);
            if (confirmation == 1) {
                DetalleTB detalleTB = new DetalleTB();
                detalleTB.setIdDetalle(idDetalle);
                detalleTB.setIdMantenimiento(idMantenimiento);
                detalleTB.setNombre(txtDetalle.getText().trim());
                detalleTB.setDescripcion("");
                detalleTB.setEstado("1");
                detalleTB.setUsuarioRegistro(Session.USER_ID);
                String result = DetalleADO.CrudEntity(detalleTB);
                if (result.equalsIgnoreCase("registered")) {
                    Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.INFORMATION, "Detalle", "Registrado correctamente.", false);
                    listaController.initListDetalle(idMantenimiento, "");
                    Tools.Dispose(window);
                } else if (result.equalsIgnoreCase("updated")) {
                    Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.INFORMATION, "Detalle", "Actualizado correctamente.", false);
                    Tools.Dispose(window);
                    listaController.initListDetalle(idMantenimiento, "");
                    Tools.Dispose(window);
                } else if (result.equalsIgnoreCase("duplicate")) {
                    Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Detalle", "No se puede haber 2 detalles con el mismo nombre.", false);
                    txtDetalle.requestFocus();
                } else if (result.equalsIgnoreCase("error")) {
                    Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Detalle", "No se puedo completar la ejecución.", false);
                } else {
                    Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.ERROR, "Detalle", result, false);
                }
            }

        }
    }

    @FXML
    private void onActionToRegister(ActionEvent event) {
        toValidateRegister();
    }

    @FXML
    private void onKeyPressedToRegister(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            toValidateRegister();
        }
    }

    public void setInitComponents(int idDetalle, String idMantenimiento) {
        this.idDetalle = idDetalle;
        this.idMantenimiento = idMantenimiento;
    }

    void setControllerDetalleLista(FxDetalleListaController listaController) {
        this.listaController = listaController;
    }

}
