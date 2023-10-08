import { drizzle, BetterSQLite3Database } from 'drizzle-orm/better-sqlite3';
import * as schema from './schema';
import Database from 'better-sqlite3';
 
const sqlite = new Database('sqlite.db');
export const db = drizzle(sqlite, { schema });
 