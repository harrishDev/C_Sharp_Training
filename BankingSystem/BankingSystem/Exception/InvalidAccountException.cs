﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace BankingSystem.exception
{
    public class InvalidAccountException : Exception
    {
        public InvalidAccountException(string message) : base(message) { }
    }
}
