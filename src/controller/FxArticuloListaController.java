package controller;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;
import javafx.beans.binding.Bindings;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import model.ArticuloADO;
import model.ArticuloTB;

public class FxArticuloListaController implements Initializable {

    @FXML
    private AnchorPane window;
    @FXML
    private TextField txtSearch;
    @FXML
    private TableView<ArticuloTB> tvList;
    @FXML
    private TableColumn<ArticuloTB, Integer> tcId;
    @FXML
    private TableColumn<ArticuloTB, String> tcArticulo;
    @FXML
    private TableColumn<ArticuloTB, String> tcMarca;
    @FXML
    private TableColumn<ArticuloTB, String> tcExistencias;
    @FXML
    private TableColumn<ArticuloTB, String> tcPrecio;

    private Executor exec;

    private FxComprasController comprasController;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        Tools.DisposeWindow(window, KeyEvent.KEY_PRESSED);
        exec = Executors.newCachedThreadPool((runnable) -> {
            Thread t = new Thread(runnable);
            t.setDaemon(true);
            return t;
        });

        tcId.setCellValueFactory(cellData -> cellData.getValue().getId().asObject());
        tcArticulo.setCellValueFactory(cellData -> Bindings.concat(
                cellData.getValue().getClave().get() + "\n" + cellData.getValue().getNombre().get()
        )
        );
        tcMarca.setCellValueFactory(cellData -> cellData.getValue().getMarcaName());
        tcExistencias.setCellValueFactory(cellData -> Bindings.concat(Tools.roundingValue(cellData.getValue().getCantidad().get(), 2)));
        tcPrecio.setCellValueFactory(cellData -> Bindings.concat(Tools.roundingValue(cellData.getValue().getPrecioVenta().get(), 2)));

    }

    public void fillProvidersTable(String value) {

        Task<List<ArticuloTB>> task = new Task<List<ArticuloTB>>() {
            @Override
            public ObservableList<ArticuloTB> call() {
                return ArticuloADO.ListArticulos(value);
            }
        };

        task.setOnSucceeded((WorkerStateEvent e) -> {
            tvList.setItems((ObservableList<ArticuloTB>) task.getValue());
        });

        exec.execute(task);

    }

    @FXML
    private void onKeyPressedToSearh(KeyEvent event) {
    }

    @FXML
    private void onActionToSearch(ActionEvent event) {
    }

    @FXML
    private void onMouseClickedList(MouseEvent event) throws IOException {
        if (tvList.getSelectionModel().getSelectedIndex() >= 0) {
            if (event.getClickCount() == 2) {
                URL url = getClass().getResource(Tools.FX_FILE_ARTICULOCOMPRA);
                FXMLLoader fXMLLoader = FxWindow.LoaderWindow(url);
                Parent parent = fXMLLoader.load(url.openStream());
                //Controlller here
                FxArticuloCompraController controller = fXMLLoader.getController();
                controller.setInitCompraController(comprasController);
                //
                Stage stage = FxWindow.StageLoaderModal(parent, "Agregar artículo", window.getScene().getWindow());
                stage.setResizable(false);
                stage.show();
                controller.setLoadData(tvList.getSelectionModel().getSelectedItem().getClave().get(),
                        tvList.getSelectionModel().getSelectedItem().getNombre().get());
            }
        }
    }

    

    void setInitComptrasController(FxComprasController comprasController) {
        this.comprasController = comprasController;
    }

}