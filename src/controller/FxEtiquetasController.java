package controller;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import static java.awt.print.Printable.NO_SUCH_PAGE;
import static java.awt.print.Printable.PAGE_EXISTS;
import java.awt.print.PrinterException;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Iterator;
import java.util.ResourceBundle;
import javafx.embed.swing.SwingFXUtils;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Bounds;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.SnapshotParameters;
import javafx.scene.control.Alert;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;
import javafx.scene.control.TextField;
import javafx.scene.image.ImageView;
import javafx.scene.image.PixelWriter;
import javafx.scene.image.WritableImage;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseButton;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import static javafx.scene.layout.Region.USE_COMPUTED_SIZE;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontPosture;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;
import javax.imageio.ImageIO;
import model.EtiquetaADO;
import model.EtiquetaTB;
import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeException;
import net.sourceforge.barbecue.BarcodeFactory;
import net.sourceforge.barbecue.output.OutputException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class FxEtiquetasController implements Initializable {

    @FXML
    private VBox window;
    @FXML
    private Pane panel;
    @FXML
    private TextField txtTexto;
    @FXML
    private ComboBox<String> cbFuente;
    @FXML
    private Spinner<Double> spFontSize;
    @FXML
    private CheckBox cbBold;
    @FXML
    private CheckBox cbItalic;
    @FXML
    private ScrollPane scrollPane;
    @FXML
    private HBox hbContent;
    @FXML
    private VBox group;
    @FXML
    private Label lblMedida;
    @FXML
    private Label lblFormato;
    @FXML
    private Label lblNombre;
    @FXML
    private ComboBox<String> cbTipo;
    @FXML
    private VBox vbCotenido;
    @FXML
    private HBox hbTipo;
    @FXML
    private ComboBox<String> cbModulo;
    @FXML
    private ComboBox<ModelEtiqueta> cbCampo;

    private Text textReferent;

    private CodBar codBarReferent;

    private SelectionModel selectionModel;

    private AnchorPane content;

    private int idEtiqueta;

    private int tipoEtiqueta;

    private double mouseAnchorX;

    private double mouseAnchorY;

    private double translateAnchorX;

    private double translateAnchorY;

    private boolean etiquetaProceso;

    private String nombreEtiqueta;

    private double widthEtiquetaMM;

    private double heightEtiquetaMM;

    private int orientacionEtiqueta;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        etiquetaProceso = false;
        lblMedida.setText(widthEtiquetaMM + "mm x " + heightEtiquetaMM + "mm");
        cbTipo.getItems().addAll("Texto", "Variable");
        String[] fontNames = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames();
        cbFuente.getItems().addAll(Arrays.asList(fontNames));

        spFontSize.setValueFactory(new SpinnerValueFactory.DoubleSpinnerValueFactory(1, 100, 12));
        spFontSize.setOnMousePressed((event) -> {
            if (event.getButton() == MouseButton.PRIMARY) {
                if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
                    textReferent.setFont(Font.font(textReferent.getFont().getFamily(), textReferent.getFontWeight(), textReferent.getFontPosture(), spFontSize.getValue()));
                } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
                    java.awt.Font font = codBarReferent.getFont();
                    java.awt.Font newFont = new java.awt.Font(font.getFamily(), font.getStyle(), (int) ((double) spFontSize.getValue()));
                    codBarReferent.setFont(newFont);
                    codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), newFont));
                }
            }
        });
        spFontSize.getEditor().setOnAction((event) -> {
            if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
                textReferent.setFont(Font.font(textReferent.getFont().getFamily(), textReferent.getFontWeight(), textReferent.getFontPosture(), Double.parseDouble(spFontSize.getEditor().getText())));
            } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
                java.awt.Font font = codBarReferent.getFont();
                java.awt.Font newFont = new java.awt.Font(font.getFamily(), font.getStyle(), (int) ((double) spFontSize.getValue()));
                codBarReferent.setFont(newFont);
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), newFont));
            }
        });
        spFontSize.getEditor().setOnKeyTyped((event) -> {
            char c = event.getCharacter().charAt(0);
            if ((c < '0' || c > '9') && (c != '\b') && (c != '.')) {
                event.consume();
            }
            if (c == '.' && spFontSize.getEditor().getText().contains(".")) {
                event.consume();
            }
        });

        selectionModel = new SelectionModel();

        window.setOnMousePressed(mouseEvent -> {
            selectionModel.clear();
            textReferent = null;
            codBarReferent = null;
        });
        window.getStylesheets().add(getClass().getResource("application.css").toExternalForm());

//        group.layoutBoundsProperty().addListener((observable, oldBounds, newBounds) -> {
//            hbContent.setMinWidth(newBounds.getWidth());
//            hbContent.setMinHeight(newBounds.getHeight());
//        });
//
//        scrollPane.viewportBoundsProperty().addListener((observable, oldBounds, newBounds) -> {
//            hbContent.setPrefSize(newBounds.getWidth(), newBounds.getHeight());
//        });
        hbContent.setOnScroll(evt -> {
            if (etiquetaProceso) {
                if (evt.isControlDown()) {
                    evt.consume();
                    final double zoomFactor = evt.getDeltaY() > 0 ? 1.2 : 1 / 1.2;

//                    Bounds groupBounds = group.getLayoutBounds();
//                    final Bounds viewportBounds = scrollPane.getViewportBounds();
                    // calculate pixel offsets from [0, 1] range
//                double valX = scrollPane.getHvalue() * (groupBounds.getWidth() - viewportBounds.getWidth());
//                double valY = scrollPane.getVvalue() * (groupBounds.getHeight() - viewportBounds.getHeight());
                    // convert content coordinates to zoomTarget coordinates
//                Point2D posInZoomTarget = panel.parentToLocal(group.parentToLocal(new Point2D(evt.getX(), evt.getY())));
                    // calculate adjustment of scroll position (pixels)
//                Point2D adjustment = panel.getLocalToParentTransform().deltaTransform(posInZoomTarget.multiply(zoomFactor - 1));
                    // do the resizing
                    panel.setScaleX(zoomFactor * panel.getScaleX());
                    panel.setScaleY(zoomFactor * panel.getScaleY());

                    // refresh ScrollPane scroll positions & content bounds
                    scrollPane.layout();

                    // convert back to [0, 1] range
                    // (too large/small values are automatically corrected by ScrollPane)
//                groupBounds = group.getLayoutBounds();
//                scrollPane.setHvalue((valX + adjustment.getX()) / (groupBounds.getWidth() - viewportBounds.getWidth()));
//                scrollPane.setVvalue((valY + adjustment.getY()) / (groupBounds.getHeight() - viewportBounds.getHeight()));
                }
            }

        });

    }

    public void loadEtiqueta(int idEtiqueta, String ruta) {
        if (ruta != null) {
            this.idEtiqueta = idEtiqueta;
            panel.getChildren().clear();
            Group selectionLayer = new Group();
            panel.getChildren().add(selectionLayer);
            selectionModel.setGroup(selectionLayer);
            JSONObject jSONObject = obtenerObjetoJSON(ruta);
            if (jSONObject.get("cuerpo") != null) {
                JSONObject object = obtenerObjetoJSON(jSONObject.get("cuerpo").toString());
                etiquetaProceso = true;
                nombreEtiqueta = String.valueOf(object.get("name"));
                widthEtiquetaMM = Double.parseDouble(object.get("width").toString());
                heightEtiquetaMM = Double.parseDouble(object.get("height").toString());
                orientacionEtiqueta = Integer.parseInt(object.get("orientation").toString());
                tipoEtiqueta = Integer.parseInt(object.get("type").toString());
                cbModulo.getItems().clear();
                switch (tipoEtiqueta) {
                    case 1:
                        cbModulo.getItems().addAll("Artículo", "Empresa");
                        break;
                    case 2:
                        cbModulo.getItems().addAll("Artículo", "Empresa");
                        break;
                    case 3:
                        cbModulo.getItems().addAll("Compra", "Empresa");
                        break;
                    default:
                        break;
                }
                if (orientacionEtiqueta == PageFormat.PORTRAIT) {
                    panel.setPrefSize(converMmToPixel(widthEtiquetaMM), converMmToPixel(heightEtiquetaMM));
                } else {
                    panel.setPrefSize(converMmToPixel(heightEtiquetaMM), converMmToPixel(widthEtiquetaMM));
                }
                lblMedida.setText(widthEtiquetaMM + "mm x " + heightEtiquetaMM + "mm");
                lblNombre.setText(nombreEtiqueta);
                lblFormato.setText(String.valueOf(object.get("typeName")));
                if (object.get("childs") != null) {
                    JSONArray array = obtenerArrayJSON(object.get("childs").toString());
                    Iterator it = array.iterator();
                    while (it.hasNext()) {
                        JSONObject objectchild = obtenerObjetoJSON(it.next().toString());
                        if (objectchild.get("type") != null) {
                            if (String.valueOf(objectchild.get("type")).equalsIgnoreCase("text")) {
                                panel.getChildren().add(addText(
                                        String.valueOf(objectchild.get("text")),
                                        Double.parseDouble(objectchild.get("x").toString()),
                                        Double.parseDouble(objectchild.get("y").toString()),
                                        Double.parseDouble(objectchild.get("with").toString()),
                                        Double.parseDouble(objectchild.get("height").toString()),
                                        String.valueOf(objectchild.get("fontname")),
                                        Double.parseDouble(objectchild.get("fontsize").toString()),
                                        Integer.parseInt(objectchild.get("tipo").toString()),
                                        Integer.parseInt(objectchild.get("modulo").toString()),
                                        Integer.parseInt(objectchild.get("campo").toString()),
                                        String.valueOf(objectchild.get("variable").toString())
                                ));
                            } else if (String.valueOf(objectchild.get("type")).equalsIgnoreCase("codebar")) {
                                panel.getChildren().add(addBarCode(
                                        String.valueOf(objectchild.get("text")),
                                        Double.parseDouble(objectchild.get("x").toString()),
                                        Double.parseDouble(objectchild.get("y").toString()),
                                        Double.parseDouble(objectchild.get("with").toString()),
                                        Double.parseDouble(objectchild.get("height").toString()),
                                        String.valueOf(objectchild.get("fontname")),
                                        Double.parseDouble(objectchild.get("fontsize").toString()),
                                        Integer.parseInt(objectchild.get("tipo").toString()),
                                        Integer.parseInt(objectchild.get("modulo").toString()),
                                        Integer.parseInt(objectchild.get("campo").toString()),
                                        String.valueOf(objectchild.get("variable").toString())
                                ));
                            }
                        }
                    }
                }
            }
        }
    }

    public void newEtiqueta(String nombre, double ancho, double alto, int orientacion, int tipo, String nombreTipo) {
        idEtiqueta = 0;
        panel.getChildren().clear();
        etiquetaProceso = true;
        Group selectionLayer = new Group();
        panel.getChildren().add(selectionLayer);
        selectionModel.setGroup(selectionLayer);
        nombreEtiqueta = nombre;
        widthEtiquetaMM = ancho;
        heightEtiquetaMM = alto;
        orientacionEtiqueta = orientacion;
        tipoEtiqueta = tipo;
        cbModulo.getItems().clear();
        switch (tipoEtiqueta) {
            case 1:
                cbModulo.getItems().addAll("Artículo", "Empresa");
                break;
            case 2:
                cbModulo.getItems().addAll("Artículo", "Empresa");
                break;
            case 3:
                cbModulo.getItems().addAll("Compra", "Empresa");
                break;
            default:
                break;
        }
        if (orientacion == PageFormat.PORTRAIT) {
            panel.setPrefSize(converMmToPixel(widthEtiquetaMM), converMmToPixel(heightEtiquetaMM));
        } else {
            panel.setPrefSize(converMmToPixel(heightEtiquetaMM), converMmToPixel(widthEtiquetaMM));
        }
        lblMedida.setText(widthEtiquetaMM + "mm x " + heightEtiquetaMM + "mm");
        lblNombre.setText(nombreEtiqueta);
        lblFormato.setText(nombreTipo);
    }

    private void saveEtiqueta() {
        if (!etiquetaProceso) {
            return;
        }
        try {
            JSONObject sampleObject = new JSONObject();
            JSONObject cuerpo = new JSONObject();
            cuerpo.put("name", nombreEtiqueta);
            cuerpo.put("type", tipoEtiqueta);
            cuerpo.put("typeName", lblFormato.getText());
            cuerpo.put("width", widthEtiquetaMM);
            cuerpo.put("height", heightEtiquetaMM);
            cuerpo.put("orientation", orientacionEtiqueta);

            JSONArray kids = new JSONArray();
            panel.getChildren().forEach((node) -> {
                if (node instanceof Text) {
                    Text text = (Text) node;
                    JSONObject child = new JSONObject();
                    child.put("type", "text");
                    child.put("text", text.getText());
                    child.put("x", text.getTranslateX());
                    child.put("y", text.getTranslateY());
                    child.put("with", text.getPrefWidth());
                    child.put("height", text.getPrefHeight());
                    child.put("fontname", text.getFont().getFamily());
                    child.put("fontsize", text.getFont().getSize());
                    child.put("fontwight", "" + text.getFontWeight());
                    child.put("fontpostura", "" + text.getFontPosture());
                    child.put("tipo", "" + text.getTipo());
                    child.put("modulo", "" + text.getModulo());
                    child.put("campo", "" + text.getCampo());
                    child.put("variable", text.getVariable());
                    kids.add(child);
                } else if (node instanceof CodBar) {
                    CodBar codBar = (CodBar) node;
                    JSONObject child = new JSONObject();
                    child.put("type", "codebar");
                    child.put("text", codBar.getTexto());
                    child.put("x", codBar.getTranslateX());
                    child.put("y", codBar.getTranslateY());
                    child.put("with", codBar.getFitWidth());
                    child.put("height", codBar.getFitHeight());
                    child.put("fontname", codBar.getFont().getFamily());
                    child.put("fontsize", codBar.getFont().getSize());
                    child.put("fontstyle", codBar.getFont().getStyle());
                    child.put("tipo", "" + codBar.getTipo());
                    child.put("modulo", "" + codBar.getModulo());
                    child.put("campo", "" + codBar.getCampo());
                    child.put("variable", codBar.getVariable());
                    kids.add(child);
                }
            });
            cuerpo.put("childs", kids);
            sampleObject.put("cuerpo", cuerpo);

            Files.write(Paths.get("./archivos/etiqueta.json"), sampleObject.toJSONString().getBytes());
            EtiquetaTB etiquetaTB = new EtiquetaTB();
            etiquetaTB.setIdEtiqueta(idEtiqueta);
            etiquetaTB.setNombre(lblNombre.getText().trim());
            etiquetaTB.setTipo(tipoEtiqueta);
            etiquetaTB.setPredeterminado(true);
            etiquetaTB.setRuta(sampleObject.toJSONString());
            etiquetaTB.setMedida(lblMedida.getText());

            panel.setScaleX(1.0);
            panel.setScaleY(1.0);
            WritableImage image = panel.snapshot(new SnapshotParameters(), new WritableImage((int) panel.getWidth(), (int) panel.getHeight()));
            RenderedImage buffered = SwingFXUtils.fromFXImage(image, null);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(buffered, "png", baos);
            etiquetaTB.setImagen(baos.toByteArray());

            String result = EtiquetaADO.CrudEtiquetas(etiquetaTB);
            if (result.equalsIgnoreCase("duplicate")) {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.WARNING, "Etiqueta", "El nombre del formato ya existe, intente con otro.", false);
            } else if (result.equalsIgnoreCase("updated")) {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.INFORMATION, "Etiqueta", "Se actualizo correctamente el formato.", false);
                //Session.RUTA_TICKET_VENTA = sampleObject.toJSONString();
                clearEtiqueta();
            } else if (result.equalsIgnoreCase("registered")) {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.INFORMATION, "Etiqueta", "Se guardo correctamente el formato.", false);
                //Session.RUTA_TICKET_VENTA = sampleObject.toJSONString();
                clearEtiqueta();
            } else {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.ERROR, "Etiqueta", result, false);
            }
        } catch (IOException ex) {

        }

    }

    private void clearEtiqueta() {
        etiquetaProceso = false;
        idEtiqueta = 0;
        nombreEtiqueta = "";
        widthEtiquetaMM = 0;
        heightEtiquetaMM = 0;
        orientacionEtiqueta = 0;
        tipoEtiqueta = 0;
        panel.getChildren().clear();
        panel.setPrefSize(0, 0);
        lblMedida.setText("0");
        lblNombre.setText("-");
        lblFormato.setText("-");
    }

    private JSONObject obtenerObjetoJSON(final String codigoJSON) {
        JSONParser lector = new JSONParser();
        JSONObject objectJSON = null;
        try {
            Object recuperado = lector.parse(codigoJSON);
            objectJSON = (JSONObject) recuperado;
        } catch (ParseException ex) {
            System.out.println("Posicion:" + ex.getPosition());
            System.out.println(ex);
        }
        return objectJSON;
    }

    private JSONArray obtenerArrayJSON(final String codigoJSON) {
        JSONParser lector = new JSONParser();
        JSONArray arrayJSON = null;

        try {
            Object recuperado = lector.parse(codigoJSON);
            arrayJSON = (JSONArray) recuperado;
        } catch (ParseException e) {
            System.out.println("Posicion: " + e.getPosition());
            System.out.println(e);
        }

        return arrayJSON;
    }

    private String leerArchivoTexto(String ruta) {
        String contenido = "";
        InputStream inStream = null;
        BufferedInputStream bis = null;
        try {
            inStream = new FileInputStream(ruta);
            bis = new BufferedInputStream(inStream);
            while (bis.available() > 0) {
                char c = (char) bis.read();
                contenido += c;
            }
        } catch (IOException e) {
            System.out.println(e.getLocalizedMessage());
        } finally {
            try {
                if (inStream != null) {
                    inStream.close();
                }
                if (bis != null) {
                    bis.close();
                }
            } catch (IOException ex) {
                System.out.println(ex.getLocalizedMessage());
            }
        }
        return contenido;
    }

    private void InitializationTransparentBackground() {
        Session.PANE.setStyle("-fx-background-color: black");
        Session.PANE.setTranslateX(0);
        Session.PANE.setTranslateY(0);
        Session.PANE.setPrefWidth(Session.WIDTH_WINDOW);
        Session.PANE.setPrefHeight(Session.HEIGHT_WINDOW);
        Session.PANE.setOpacity(0.7f);
        content.getChildren().add(Session.PANE);
    }

    private WritableImage generateBarCode(String value, java.awt.Font font) {
        int heightBuffer = (int) (60);
        WritableImage wr = null;
        try {
            Barcode barCode = BarcodeFactory.createCode128(value);
            barCode.setBarHeight(30);
            barCode.setBarWidth(1);
            barCode.setDrawingText(true);
            barCode.setFont(font);
            BufferedImage bufferedImage = new BufferedImage(barCode.getWidth(), heightBuffer, BufferedImage.TYPE_INT_ARGB);
            Graphics graphics = bufferedImage.createGraphics();
            barCode.draw((Graphics2D) graphics, 0, 0);
            wr = new WritableImage(bufferedImage.getWidth(), bufferedImage.getHeight());
            PixelWriter pw = wr.getPixelWriter();
            for (int px = 0; px < bufferedImage.getWidth(); px++) {
                for (int py = 0; py < bufferedImage.getHeight(); py++) {
                    pw.setArgb(px, py, bufferedImage.getRGB(px, py));
                }
            }
        } catch (BarcodeException | OutputException ex) {

        }
//        Barcode128 barcode128 = new Barcode128();
//        barcode128.setCode(value);
//        java.awt.Image image = barcode128.createAwtImage(java.awt.Color.BLACK, java.awt.Color.WHITE);
//        BufferedImage bufferedImage = new BufferedImage(widthBuffer, heightBuffer, BufferedImage.TYPE_INT_ARGB);
//        Graphics2D graphics = bufferedImage.createGraphics();
//        graphics.setColor(java.awt.Color.WHITE);
//        graphics.fillRect(0, 0, widthBuffer, heightBuffer);
//        graphics.drawImage(image, 0, 0, widthBuffer, 30, null);
//        java.awt.Font font = new java.awt.Font("Lucida Sans Typewriter", java.awt.Font.BOLD, 16);
//        graphics.setFont(font);
//        graphics.setColor(java.awt.Color.BLACK);
//        graphics.drawString(value, (widthBuffer - graphics.getFontMetrics(font).stringWidth(value)) / 2, 48);
//        graphics.dispose();
        return wr;
    }

    private ImageView addBarCode(String value, double x, double y, double width, double height, String fontFamily, double size, int tipo, int modulo, int campo, String variable) {
        CodBar ivCodigo = new CodBar(value, x, y, new java.awt.Font("Lucida Sans Typewriter", java.awt.Font.BOLD, 16));
        ivCodigo.setImage(generateBarCode(ivCodigo.getTexto(), ivCodigo.getFont()));
        ivCodigo.setFitWidth(width == -1 ? ivCodigo.getImage().getWidth() : width);
        ivCodigo.setFitHeight(height == -1 ? ivCodigo.getImage().getHeight() : height);
        ivCodigo.setTipo(tipo);
        ivCodigo.setModulo(modulo);
        ivCodigo.setCampo(campo);
        ivCodigo.setVariable(variable);
        ivCodigo.setOnMousePressed(event -> {
            textReferent = null;
            codBarReferent = ivCodigo;
            if (codBarReferent.getTipo() == 0) {
                cbTipo.getSelectionModel().select(codBarReferent.getTipo());
                hbTipo.setVisible(false);
                vbCotenido.setVisible(true);
            } else {
                cbTipo.getSelectionModel().select(codBarReferent.getTipo());
                cbModulo.getSelectionModel().select(codBarReferent.getModulo());
                cbCampo.getSelectionModel().select(codBarReferent.getCampo());
                vbCotenido.setVisible(false);
                hbTipo.setVisible(true);
            }

            cbFuente.getSelectionModel().select(codBarReferent.getFont().getFamily());
            spFontSize.getValueFactory().setValue((double) codBarReferent.getFont().getSize());
            txtTexto.setText(codBarReferent.getTexto());

            selectionModel.clear();
            selectionModel.add(ivCodigo);

            mouseAnchorX = event.getSceneX();
            mouseAnchorY = event.getSceneY();

            translateAnchorX = ivCodigo.getTranslateX();
            translateAnchorY = ivCodigo.getTranslateY();

            // consume event, so that scene won't get it (which clears selection)
            event.consume();
        });
        ivCodigo.setOnMouseDragged(event -> {
            if (!event.isPrimaryButtonDown()) {
                return;
            }
            ivCodigo.setTranslateX(translateAnchorX + ((event.getSceneX() - mouseAnchorX) / panel.getScaleX()));
            ivCodigo.setTranslateY(translateAnchorY + ((event.getSceneY() - mouseAnchorY) / panel.getScaleY()));
            event.consume();
        });

        return ivCodigo;
    }

    private Text addText(String value, double x, double y, double width, double height, String fontFamily, double size, int tipo, int modulo, int campo, String variable) {
        Text text = new Text(value, x, y);
        text.setFontText(fontFamily, FontWeight.BOLD, FontPosture.REGULAR, size);
        text.setPrefSize(width == -1 ? USE_COMPUTED_SIZE : width, height == -1 ? USE_COMPUTED_SIZE : height);
        text.setTipo(tipo);
        text.setModulo(modulo);
        text.setCampo(campo);
        text.setVariable(variable);
        text.setOnMousePressed(event -> {
            codBarReferent = null;
            textReferent = text;
            if (textReferent.getTipo() == 0) {
                cbTipo.getSelectionModel().select(textReferent.getTipo());
                hbTipo.setVisible(false);
                vbCotenido.setVisible(true);
            } else {
                cbTipo.getSelectionModel().select(textReferent.getTipo());
                cbModulo.getSelectionModel().select(textReferent.getModulo());
                cbCampo.getSelectionModel().select(textReferent.getCampo());
                vbCotenido.setVisible(false);
                hbTipo.setVisible(true);
            }

            cbFuente.getSelectionModel().select(textReferent.getFont().getFamily());
            spFontSize.getValueFactory().setValue(textReferent.getFont().getSize());
            txtTexto.setText(textReferent.getText());

            cbBold.setSelected(textReferent.isBold());
            cbItalic.setSelected(textReferent.isItalic());

            selectionModel.clear();
            selectionModel.add(text);

            mouseAnchorX = event.getSceneX();
            mouseAnchorY = event.getSceneY();

            translateAnchorX = text.getTranslateX();
            translateAnchorY = text.getTranslateY();

            // consume event, so that scene won't get it (which clears selection)
            event.consume();
        });
        text.setOnMouseDragged(event -> {
            if (!event.isPrimaryButtonDown()) {
                return;
            }
            text.setTranslateX(translateAnchorX + ((event.getSceneX() - mouseAnchorX) / panel.getScaleX()));
            text.setTranslateY(translateAnchorY + ((event.getSceneY() - mouseAnchorY) / panel.getScaleY()));
            event.consume();
        });

        return text;
    }

    private void eventNuevo() {
        try {
            InitializationTransparentBackground();
            URL url = getClass().getResource(Tools.FX_FILE_ETIQUETASNUEVO);
            FXMLLoader fXMLLoader = FxWindow.LoaderWindow(url);
            Parent parent = fXMLLoader.load(url.openStream());
            //Controlller here
            FxEtiquetasNuevoController controller = fXMLLoader.getController();
            controller.setInitEtiquetasController(this);
            //
            Stage stage = FxWindow.StageLoaderModal(parent, "Nueva Etiqueta", window.getScene().getWindow());
            stage.setResizable(false);
            stage.sizeToScene();
            stage.setOnHiding((WindowEvent WindowEvent) -> {
                content.getChildren().remove(Session.PANE);
            });
            stage.show();
        } catch (IOException exception) {

        }
    }

    private void eventSearch() {
        try {
            InitializationTransparentBackground();
            URL url = getClass().getResource(Tools.FX_FILE_ETIQUETASBUSQUEDA);
            FXMLLoader fXMLLoader = FxWindow.LoaderWindow(url);
            Parent parent = fXMLLoader.load(url.openStream());
            //Controlller here
            FxEtiquetasBusquedaController controller = fXMLLoader.getController();
            controller.setInitEtiquetasController(this);
            controller.onLoadEtiquetas(0);
            //
            Stage stage = FxWindow.StageLoaderModal(parent, "Buscar etiquetas", window.getScene().getWindow());
            stage.setResizable(false);
            stage.sizeToScene();
            stage.setOnHiding((WindowEvent WindowEvent) -> {
                content.getChildren().remove(Session.PANE);
            });
            stage.show();
        } catch (IOException exception) {

        }
    }

    private void eventWindowPrint(Printable billPrintableEtiquetas) {
        try {
            InitializationTransparentBackground();
            URL url = getClass().getResource(Tools.FX_FILE_IMPRESORAETIQUETA);
            FXMLLoader fXMLLoader = FxWindow.LoaderWindow(url);
            Parent parent = fXMLLoader.load(url.openStream());
            //Controlller here
            FxImpresoraEtiquetaController controller = fXMLLoader.getController();
            controller.loadImpresoraEtiqueta((BillPrintableEtiquetas) billPrintableEtiquetas, widthEtiquetaMM, heightEtiquetaMM, orientacionEtiqueta);
            //
            Stage stage = FxWindow.StageLoaderModal(parent, "Ventana de impresión", window.getScene().getWindow());
            stage.setResizable(false);
            stage.sizeToScene();
            stage.setOnHiding((WindowEvent WindowEvent) -> {
                content.getChildren().remove(Session.PANE);
            });
            stage.show();
        } catch (IOException exception) {

        }
    }

    private void eventEliminar() {
        short value = Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.CONFIRMATION, "Etiqueta", "¿Está seguro de eliminar la etiqueta?", true);
        if (value == 1) {
            String result = EtiquetaADO.dropEtiqueta(idEtiqueta);
            if (result.equalsIgnoreCase("removed")) {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.INFORMATION, "Etiqueta", "Se elimino correctamente la etiqueta.", false);
                clearEtiqueta();
            } else {
                Tools.AlertMessage(window.getScene().getWindow(), Alert.AlertType.ERROR, "Etiqueta", result, false);
            }
        }
    }

    @FXML
    private void onKeyPressedSearch(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            eventSearch();
        }
    }

    @FXML
    private void onActionSearch(ActionEvent event) {
        eventSearch();
    }

    @FXML
    private void onKeyPressNuevo(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            eventNuevo();
        }
    }

    @FXML
    private void onActionNuevo(ActionEvent event) {
        eventNuevo();
    }

    private void onKeyPressEditar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {

        }
    }

    @FXML
    private void onKeyPressedSave(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            saveEtiqueta();
        }
    }

    @FXML
    private void onActionSave(ActionEvent event) {
        saveEtiqueta();
    }

    @FXML
    private void onKeyPressedPrint(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            eventImprimir();
        }
    }

    @FXML
    private void onActionPrint(ActionEvent event) {
        eventImprimir();
    }

    @FXML
    private void onKeyPressedEliminar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            eventEliminar();
        }
    }

    @FXML
    private void onActionEliminar(ActionEvent event) {
        eventEliminar();
    }

    @FXML
    private void onKeyPressedTexto(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            if (!etiquetaProceso) {
                return;
            }
            panel.getChildren().add(addText("Texto de muestra", 0, 0, -1, -1, "Lucida Sans Typewriter", 16, 0, 0, 0, ""));
        }
    }

    @FXML
    private void onActionTexto(ActionEvent event) {
        if (!etiquetaProceso) {
            return;
        }
        panel.getChildren().add(addText("Texto de muestra", 0, 0, -1, -1, "Lucida Sans Typewriter", 16, 0, 0, 0, ""));
    }

    @FXML
    private void onKeyPressedCodBar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            if (!etiquetaProceso) {
                return;
            }
            panel.getChildren().add(addBarCode("12345678", 0, 0, -1, -1, "Lucida Sans Typewriter", 16, 0, 0, 0, ""));
        }
    }

    @FXML
    private void onActionCodBar(ActionEvent event) {
        if (!etiquetaProceso) {
            return;
        }
        panel.getChildren().add(addBarCode("12345678", 0, 0, -1, -1, "Lucida Sans Typewriter", 16, 0, 0, 0, ""));
    }

    @FXML
    private void onKeyPressedQuitar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
                panel.getChildren().remove(selectionModel.getNodeSelection());
                selectionModel.clear();
            } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
                panel.getChildren().remove(selectionModel.getNodeSelection());
                selectionModel.clear();
            }
        }
    }

    @FXML
    private void onActionQuitar(ActionEvent event) {
        if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
            panel.getChildren().remove(selectionModel.getNodeSelection());
            selectionModel.clear();
        } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
            panel.getChildren().remove(selectionModel.getNodeSelection());
            selectionModel.clear();
        }
    }

    @FXML
    private void onActionEditTexto(ActionEvent event) {
        if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
            if (!txtTexto.getText().trim().isEmpty()) {
                textReferent.setText(txtTexto.getText().trim());
            } else {
                textReferent.setText("Texto de referencia.");
            }
        } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
            if (!txtTexto.getText().trim().isEmpty()) {
                codBarReferent.setTexto(txtTexto.getText().trim());
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), codBarReferent.getFont()));
            } else {
                codBarReferent.setTexto("12345678");
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), codBarReferent.getFont()));
            }
        }
    }

    @FXML
    private void onActionFuente(ActionEvent event) {
        if (cbFuente.getSelectionModel().getSelectedIndex() >= 0) {
            if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
                textReferent.setFont(Font.font(cbFuente.getSelectionModel().getSelectedItem(), textReferent.getFontWeight(), textReferent.getFontPosture(), textReferent.getFont().getSize()));
            } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
                java.awt.Font font = codBarReferent.getFont();
                java.awt.Font newFont = new java.awt.Font(cbFuente.getSelectionModel().getSelectedItem(), font.getStyle(), font.getSize());
                codBarReferent.setFont(newFont);
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), newFont));
            }
        }
    }

    @FXML
    private void onActionBold(ActionEvent event) {
        if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
            if (textReferent.isBold()) {
                textReferent.setFont(
                        Font.font(textReferent.getFont().getFamily(),
                                FontWeight.NORMAL,
                                textReferent.getFontPosture(),
                                spFontSize.getValue()));
                textReferent.setBold(false);
                textReferent.setFontWeight(FontWeight.NORMAL);
            } else {
                textReferent.setFont(
                        Font.font(textReferent.getFont().getFamily(),
                                FontWeight.BOLD,
                                textReferent.getFontPosture(),
                                spFontSize.getValue()));
                textReferent.setBold(true);
                textReferent.setFontWeight(FontWeight.BOLD);
            }
        }
    }

    @FXML
    private void onActionItalic(ActionEvent event) {
        if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
            if (textReferent.isItalic()) {
                textReferent.setFont(
                        Font.font(textReferent.getFont().getFamily(),
                                textReferent.getFontWeight(),
                                FontPosture.REGULAR,
                                spFontSize.getValue()));
                textReferent.setItalic(false);
                textReferent.setFontPosture(FontPosture.REGULAR);
            } else {
                textReferent.setFont(
                        Font.font(textReferent.getFont().getFamily(),
                                textReferent.getFontWeight(),
                                FontPosture.ITALIC,
                                spFontSize.getValue()));
                textReferent.setItalic(true);
                textReferent.setFontPosture(FontPosture.ITALIC);
            }
        }
    }

    private void eventImprimir() {
        if (!etiquetaProceso) {
            return;
        }
        Pane newPane = panel;
        newPane.setScaleX(1.0);
        newPane.setScaleY(1.0);
        WritableImage image = createScaledView(newPane, 4);
        BillPrintableEtiquetas billPrintable = new BillPrintableEtiquetas(SwingFXUtils.fromFXImage(image, null));
        eventWindowPrint(billPrintable);

//        File file = new File("C:/Users/Aleza/Desktop/temp2.png");
//        WritableImage image = createScaledView(panel, 2);
//        RenderedImage renderedImage = SwingFXUtils.fromFXImage(image, null);
//        ImageIO.write(renderedImage, "png", file);
    }

    public double converMmToPoint(double mm) {
        return (mm * 2.83465) / 1;
    }

    public double converMmToPixel(double mm) {
        return BigDecimal.valueOf((mm * 3.7795275591) / 1).setScale(0, RoundingMode.HALF_UP).doubleValue();
    }

    private static WritableImage createScaledView(Node node, int scale) {
        final Bounds bounds = node.getLayoutBounds();
        final WritableImage image = new WritableImage(
                (int) Math.round(bounds.getWidth() * scale),
                (int) Math.round(bounds.getHeight() * scale));
        final SnapshotParameters spa = new SnapshotParameters();
        spa.setTransform(javafx.scene.transform.Transform.scale(scale, scale));
        return node.snapshot(spa, image);
    }

    private void eventAcercar() {
        if (!etiquetaProceso) {
            return;
        }
        final double zoomFactor = 1.2;
        // do the resizing
        panel.setScaleX(zoomFactor * panel.getScaleX());
        panel.setScaleY(zoomFactor * panel.getScaleY());
        // refresh ScrollPane scroll positions & content bounds
        scrollPane.layout();
    }

    private void eventAlejar() {
        if (!etiquetaProceso) {
            return;
        }
        final double zoomFactor = 1 / 1.2;
        // do the resizing
        panel.setScaleX(zoomFactor * panel.getScaleX());
        panel.setScaleY(zoomFactor * panel.getScaleY());
        // refresh ScrollPane scroll positions & content bounds
        scrollPane.layout();
    }

    @FXML
    private void onKeyPressedAcercar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            eventAcercar();
        }
    }

    @FXML
    private void onActionAcercar(ActionEvent event) {
        eventAcercar();
    }

    @FXML
    private void onKeyPressedAlejar(KeyEvent event) {
        if (event.getCode() == KeyCode.ENTER) {
            eventAlejar();
        }
    }

    @FXML
    private void onActionAlejar(ActionEvent event) {
        eventAlejar();
    }

    @FXML
    private void onActionTipo(ActionEvent event) {
        if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
            if (cbTipo.getSelectionModel().getSelectedIndex() == 0) {
                hbTipo.setVisible(false);
                vbCotenido.setVisible(true);
                textReferent.setText("Texto de muestra");
                textReferent.setTipo(0);
                textReferent.setModulo(0);
                textReferent.setCampo(0);
                textReferent.setVariable("");
            } else {
                vbCotenido.setVisible(false);
                hbTipo.setVisible(true);
                cbModulo.getSelectionModel().select(textReferent.getModulo());
                cbCampo.getSelectionModel().select(textReferent.getCampo());
                textReferent.setTipo(1);
                textReferent.setText("V->" + cbCampo.getSelectionModel().getSelectedItem().getNombre());
                textReferent.setVariable(cbCampo.getSelectionModel().getSelectedItem().getClave());
            }
        } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
            if (cbTipo.getSelectionModel().getSelectedIndex() == 0) {
                hbTipo.setVisible(false);
                vbCotenido.setVisible(true);
                codBarReferent.setTexto("12345678");
                codBarReferent.setTipo(0);
                codBarReferent.setModulo(0);
                codBarReferent.setCampo(0);
                codBarReferent.setVariable("");
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), codBarReferent.getFont()));
            } else {
                vbCotenido.setVisible(false);
                hbTipo.setVisible(true);
                cbModulo.getSelectionModel().select(codBarReferent.getModulo());
                cbCampo.getSelectionModel().select(codBarReferent.getCampo());
                codBarReferent.setTipo(1);
                codBarReferent.setTexto("V->" + cbCampo.getSelectionModel().getSelectedItem().getNombre());
                codBarReferent.setVariable(cbCampo.getSelectionModel().getSelectedItem().getClave());
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), codBarReferent.getFont()));
            }
        }
    }

    @FXML
    private void onActionModulo(ActionEvent event) {
        if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
            switch (tipoEtiqueta) {
                case 1:
                    cbCampo.getItems().clear();
                    if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Artículo")) {
                        textReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Clave", "clave_articulo"),
                                new ModelEtiqueta("Clave Alterna", "clave_alterna"),
                                new ModelEtiqueta("Descripción", "descripcion"),
                                new ModelEtiqueta("Precio", "precio")
                        );
                        cbCampo.getSelectionModel().select(0);
                        textReferent.setCampo(0);
                    } else if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Empresa")) {
                        textReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Giro Comercial", "girocomercial_empresa"),
                                new ModelEtiqueta("Representante", "representante_empresa"),
                                new ModelEtiqueta("Teléfono", "telefono_empresa"),
                                new ModelEtiqueta("Celular", "celular_empresa")
                        );
                        cbCampo.getSelectionModel().select(0);
                        textReferent.setCampo(0);
                    }
                    break;
                case 2:
                    cbCampo.getItems().clear();
                    if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Artículo")) {
                        textReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Clave", "clave_articulo"),
                                new ModelEtiqueta("Clave Alterna", "clave_alterna"),
                                new ModelEtiqueta("Descripción", "descripcion"),
                                new ModelEtiqueta("Precio", "precio"),
                                new ModelEtiqueta("Fecha de Registro", "fecha_registro"),
                                new ModelEtiqueta("Fecha de Vencimiento", "fecha_vencimiento")
                        );
                        cbCampo.getSelectionModel().select(0);
                        textReferent.setCampo(0);
                    } else if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Empresa")) {
                        textReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Giro Comercial", "girocomercial_empresa"),
                                new ModelEtiqueta("Representante", "representante_empresa"),
                                new ModelEtiqueta("Teléfono", "telefono_empresa"),
                                new ModelEtiqueta("Celular", "celular_empresa")
                        );
                        cbCampo.getSelectionModel().select(0);
                        textReferent.setCampo(0);
                    }
                    break;
                case 3:
                    cbCampo.getItems().clear();
                    if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Compra")) {

                    } else if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Empresa")) {

                    }
                    break;
                default:
                    break;
            }
        } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
            switch (tipoEtiqueta) {
                case 1:
                    cbCampo.getItems().clear();
                    if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Artículo")) {
                        codBarReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Clave", "clave_articulo"),
                                new ModelEtiqueta("Clave Alterna", "clave_alterna"),
                                new ModelEtiqueta("Descripción", "descripcion")
                        );
                        cbCampo.getSelectionModel().select(0);
                        codBarReferent.setCampo(0);
                    } else if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Empresa")) {
                        codBarReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Giro Comercial", "girocomercial_empresa"),
                                new ModelEtiqueta("Representante", "representante_empresa"),
                                new ModelEtiqueta("Teléfono", "telefono_empresa"),
                                new ModelEtiqueta("Celular", "celular_empresa")
                        );
                        cbCampo.getSelectionModel().select(0);
                        codBarReferent.setCampo(0);
                    }
                    break;
                case 2:
                    cbCampo.getItems().clear();
                    if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Artículo")) {
                        codBarReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Clave", "clave_articulo"),
                                new ModelEtiqueta("Clave Alterna", "clave_alterna"),
                                new ModelEtiqueta("Descripción", "descripcion"),
                                new ModelEtiqueta("Fecha de Registro", "fecha_registro"),
                                new ModelEtiqueta("Fecha de Vencimiento", "fecha_vencimiento")
                        );
                        cbCampo.getSelectionModel().select(0);
                        codBarReferent.setCampo(0);
                    } else if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Empresa")) {
                        codBarReferent.setModulo(cbModulo.getSelectionModel().getSelectedIndex());
                        cbCampo.getItems().addAll(new ModelEtiqueta("Giro Comercial", "girocomercial_empresa"),
                                new ModelEtiqueta("Representante", "representante_empresa"),
                                new ModelEtiqueta("Teléfono", "telefono_empresa"),
                                new ModelEtiqueta("Celular", "celular_empresa")
                        );
                        cbCampo.getSelectionModel().select(0);
                        codBarReferent.setCampo(0);
                    }
                    break;
                case 3:
                    cbCampo.getItems().clear();
                    if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Compra")) {

                    } else if (cbModulo.getSelectionModel().getSelectedItem().equalsIgnoreCase("Empresa")) {

                    }
                    break;
                default:
                    break;
            }
        }
    }

    @FXML
    private void onActionCampo(ActionEvent event) {
        if (cbCampo.getSelectionModel().getSelectedIndex() >= 0) {
            if (textReferent != null && selectionModel.getNodeSelection() == textReferent) {
                textReferent.setCampo(cbCampo.getSelectionModel().getSelectedIndex());
                textReferent.setText("V->" + cbCampo.getSelectionModel().getSelectedItem().getNombre());
                textReferent.setVariable(cbCampo.getSelectionModel().getSelectedItem().getClave());
            } else if (codBarReferent != null && selectionModel.getNodeSelection() == codBarReferent) {
                codBarReferent.setCampo(cbCampo.getSelectionModel().getSelectedIndex());
                codBarReferent.setTexto("V->" + cbCampo.getSelectionModel().getSelectedItem().getNombre());
                codBarReferent.setVariable(cbCampo.getSelectionModel().getSelectedItem().getClave());
                codBarReferent.setImage(generateBarCode(codBarReferent.getTexto(), codBarReferent.getFont()));
            }
        }
    }

    class BillPrintableEtiquetas implements Printable {

        private final BufferedImage bufferedImage;

        public BillPrintableEtiquetas(BufferedImage bufferedImage) {
            this.bufferedImage = bufferedImage;
        }

        @Override
        public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
            if (pageIndex == 0) {
                Graphics2D g2d = (Graphics2D) graphics;
                g2d.translate((int) pageFormat.getImageableX(), (int) pageFormat.getImageableY());
                g2d.drawImage(bufferedImage, 5, -1, (int) converMmToPoint(widthEtiquetaMM), (int) converMmToPoint(heightEtiquetaMM), null);
                g2d.dispose();
                return (PAGE_EXISTS);
            } else {
                return (NO_SUCH_PAGE);
            }
        }

    }

    class ModelEtiqueta {

        private String nombre;

        private String clave;

        public ModelEtiqueta() {

        }

        public ModelEtiqueta(String nombre, String clave) {
            this.nombre = nombre;
            this.clave = clave;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public String getClave() {
            return clave;
        }

        public void setClave(String clave) {
            this.clave = clave;
        }

        @Override
        public String toString() {
            return nombre;
        }

    }

    public void setContent(AnchorPane content) {
        this.content = content;
    }

}
