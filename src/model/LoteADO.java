package model;

import controller.Tools;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

public class LoteADO {

    public static String UpdateLote(LoteTB loteTB) {
        String selectStmt = "UPDATE LoteTB set ExistenciaActual = ?,FechaCaducidad = ? WHERE IdLote = ?";
        PreparedStatement preparedStatement = null;
        String result = "";
        try {
            DBUtil.dbConnect();
            DBUtil.getConnection().setAutoCommit(false);
            preparedStatement = DBUtil.getConnection().prepareStatement(selectStmt);
            preparedStatement.setDouble(1, loteTB.getExistenciaActual());
            preparedStatement.setDate(2, Date.valueOf(loteTB.getFechaCaducidad()));
            preparedStatement.setLong(3, loteTB.getIdLote());            
            preparedStatement.addBatch();

            preparedStatement.executeBatch();
            DBUtil.getConnection().commit();
            result = "updated";

        } catch (SQLException e) {
            try {
                result = "Error en LoteADO:" + e.getLocalizedMessage();
                DBUtil.getConnection().rollback();
            } catch (SQLException ex) {
                result = "Error en LoteADO:" + ex.getLocalizedMessage();
            }
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                DBUtil.dbDisconnect();
            } catch (SQLException ex) {
                result = "Error en LoteADO:" + ex.getLocalizedMessage();
            }
        }
        return result;
    }

    public static ObservableList<LoteTB> ListLote(String value) {
        String selectStmt = "{call Sp_Listar_Lote(?)}";
        CallableStatement callableStatement = null;
        ResultSet rsEmps = null;
        ObservableList<LoteTB> empList = FXCollections.observableArrayList();
        try {
            DBUtil.dbConnect();
            callableStatement = DBUtil.getConnection().prepareCall(selectStmt);
            callableStatement.setString(1, value);
            rsEmps = callableStatement.executeQuery();

            while (rsEmps.next()) {
                LoteTB loteTB = new LoteTB();
                loteTB.setId(rsEmps.getInt("Filas"));
                loteTB.setIdLote(rsEmps.getLong("IdLote")); 
                loteTB.setNumeroLote(rsEmps.getString("NumeroLote"));
                loteTB.setArticuloTB(new ArticuloTB(rsEmps.getString("Clave"), rsEmps.getString("NombreMarca")));
                loteTB.setFechaCaducidad(rsEmps.getDate("FechaCaducidad").toLocalDate());
                loteTB.setExistenciaInicial(rsEmps.getDouble("ExistenciaInicial"));
                loteTB.setExistenciaActual(rsEmps.getDouble("ExistenciaActual"));               
                empList.add(loteTB);
            }
        } catch (SQLException e) {
            System.out.println("La operación de selección de SQL ha fallado: " + e);

        } finally {
            try {
                if (callableStatement != null) {
                    callableStatement.close();
                }
                if (rsEmps != null) {
                    rsEmps.close();
                }
                DBUtil.dbDisconnect();
            } catch (SQLException ex) {

            }
        }
        return empList;
    }

}
