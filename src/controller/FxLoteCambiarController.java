package controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.AnchorPane;
import model.LoteTB;

public class FxLoteCambiarController implements Initializable {

    @FXML
    private AnchorPane window;
    @FXML
    private TextField txtArticulo;
    @FXML
    private TextField txtLote;
    @FXML
    private TextField txtCantidad;
    @FXML
    private DatePicker dtCaducidad;
    @FXML
    private Button btnProcess;

    private FxLoteProcesoController procesoController;

    private boolean statebatch;

    private int indexbatch;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        Tools.DisposeWindow(window, KeyEvent.KEY_RELEASED);
        statebatch = false;
        indexbatch = 0;
    }

    public void setEditBatchRealizado(String[] value) {
        txtArticulo.setText(value[1] + " " + value[2]);
        txtLote.setText(value[0]);
        txtCantidad.setText(value[3]);
        Tools.actualDate(value[4], dtCaducidad);
        txtLote.setDisable(true);
        txtCantidad.setDisable(true);
        btnProcess.setText("Guardar");
    }

    public void generateBatch(String descripcion) {
        txtArticulo.setText(descripcion);
        txtLote.setDisable(true);
        txtLote.setText("LT001GENERADO");
    }

    public void setEditBatch(String[] value) {
        statebatch = true;
        indexbatch = Integer.parseInt(value[0]);
        txtLote.setText(value[1]);
        txtCantidad.setText(value[2]);
        Tools.actualDate(value[3], dtCaducidad);
    }

    @FXML
    private void onActionAgregar(ActionEvent event) {

        if (!Tools.isNumeric(txtCantidad.getText())) {
            Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Lotes", "Ingrese la cantidad de unidades del lote, por favor", false);
            txtCantidad.requestFocus();
        } else {
            if (Double.parseDouble(txtCantidad.getText()) < 1) {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Lotes", "La cantidad debe ser mayor a 0, por favor", false);
                txtCantidad.requestFocus();
            } else {
                if (dtCaducidad.getValue() == null) {
                    Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Lotes", "Ingrese la fecha de caducidad, por favor", false);
                    dtCaducidad.requestFocus();
                } else {
                    LoteTB loteTB = new LoteTB();
                    loteTB.setNumeroLote(txtLote.getText());
                    loteTB.setExistenciaActual(Double.parseDouble(txtCantidad.getText()));
                    loteTB.setExistenciaInicial(Double.parseDouble(txtCantidad.getText()));
                    loteTB.setFechaCaducidad(dtCaducidad.getValue());
                    loteTB.setIdArticulo(procesoController.getIdArticulo());
                    if (!statebatch) {
                        procesoController.getListLote().add(loteTB);
                        procesoController.calculateBatch();
                    } else {
                        procesoController.getListLote().set(indexbatch, loteTB);
                        procesoController.calculateBatch();
                    }

                    Tools.Dispose(window);
                }
            }
        }

    }

    @FXML
    private void onActionCerrar(ActionEvent event) {
        Tools.Dispose(window);
    }

    @FXML
    private void onKeyPressedAgregar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {

        }
    }

    @FXML
    private void onKeyPressedCerrar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            Tools.Dispose(window);
        }
    }

    @FXML
    private void onKeyTypedCantidad(KeyEvent event) {
        char c = event.getCharacter().charAt(0);
        if ((c < '0' || c > '9') && (c != '\b') && (c != '.') && (c != '-')) {
            event.consume();
        }
        if (c == '.' && txtCantidad.getText().contains(".") || c == '-' && txtCantidad.getText().contains("-")) {
            event.consume();
        }
    }

    public void setProcesoController(FxLoteProcesoController procesoController) {
        this.procesoController = procesoController;
    }

}
