using System.Data;
using System.Data.OleDb;

namespace BankRazor.Services;

public sealed class BankDb
{
    private readonly string _connectionString;

    public BankDb(IConfiguration configuration, IWebHostEnvironment environment)
    {
        var provider = configuration["BankDatabase:Provider"] ?? "Microsoft.ACE.OLEDB.12.0";
        var configuredPath = configuration["BankDatabase:Path"] ?? "App_Data/dbBank.mdb";
        var path = Path.IsPathRooted(configuredPath)
            ? configuredPath
            : Path.Combine(environment.ContentRootPath, configuredPath);
        _connectionString = $"Provider={provider};Data Source={path};Persist Security Info=False;";
    }

    public OleDbConnection OpenConnection()
    {
        var connection = new OleDbConnection(_connectionString);
        connection.Open();
        return connection;
    }

    public DataTable Query(string sql, params object?[] parameters)
    {
        using var connection = OpenConnection();
        using var command = new OleDbCommand(sql, connection);
        AddParameters(command, parameters);
        using var adapter = new OleDbDataAdapter(command);
        var table = new DataTable();
        adapter.Fill(table);
        return table;
    }

    public int Execute(string sql, params object?[] parameters)
    {
        using var connection = OpenConnection();
        using var command = new OleDbCommand(sql, connection);
        AddParameters(command, parameters);
        return command.ExecuteNonQuery();
    }

    public T Transaction<T>(Func<OleDbConnection, OleDbTransaction, T> work)
    {
        using var connection = OpenConnection();
        using var transaction = connection.BeginTransaction();
        try
        {
            var result = work(connection, transaction);
            transaction.Commit();
            return result;
        }
        catch
        {
            transaction.Rollback();
            throw;
        }
    }

    public static OleDbCommand Command(OleDbConnection connection, OleDbTransaction transaction, string sql, params object?[] parameters)
    {
        var command = new OleDbCommand(sql, connection, transaction);
        AddParameters(command, parameters);
        return command;
    }

    private static void AddParameters(OleDbCommand command, params object?[] parameters)
    {
        foreach (var parameter in parameters)
        {
            command.Parameters.AddWithValue("?", parameter ?? DBNull.Value);
        }
    }
}
