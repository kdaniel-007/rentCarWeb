/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.config;

/**
 *
 * @author KevDev
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL = "jdbc:sqlserver://192.168.1.129:1433;databaseName=RentCarDB;encrypt=false;trustServerCertificate=true";
    private static final String USER = "kdaniel";
    private static final String PASSWORD = "D3v0p25$";

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver SQL Server: " + e.getMessage());
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

}
